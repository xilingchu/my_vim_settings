#!/bin/bash

get_time_until_charged() {

	# parses acpitool's battery info for the remaining charge of all batteries and sums them up
	sum_remaining_charge=$(acpitool -B | grep -E 'Remaining capacity' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

	# finds the rate at which the batteries being drained at
	present_rate=$(acpitool -B | grep -E 'Present rate' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

	# divides current charge by the rate at which it's falling, then converts it into seconds for `date`
	seconds=$(bc <<< "scale = 10; ($sum_remaining_charge / $present_rate) * 3600");

	# prettifies the seconds into h:mm:ss format
	pretty_time=$(date -u -d @${seconds} +%T);

	echo $pretty_time;
}

get_battery_combined_percent() {

	# get charge of all batteries, combine them
	total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));

	# get amount of batteries in the device
	battery_number=$(acpi -b | wc -l);

	percent=$(expr $total_charge / $battery_number);

	echo $percent;
}

get_battery_charging_status() {

	if $(acpi -b | grep --quiet Discharging)
	then
		echo "🔋";
	else # acpi can give Unknown or Charging if charging, https://unix.stackexchange.com/questions/203741/lenovo-t440s-battery-status-unknown-but-charging
		echo "🔌";
	fi
}

# Please use pactl set-default-sinks <sink id> to set the usb phone as default sink.
# Both the pci sink should also be set as the default sink
# It can help automatically detect the headphone and set it as the output sink.
get_alsa_output_status() {
	# Judge if the head phone was connect.
	if $(pactl list sinks short|grep --quiet usb)
	then
		sink_id=$(pactl list sinks short|grep usb|awk '{print $1}')
		# If mute
		mute=$(pactl list sinks|grep -A 10 \#$sink_id|grep Mute|awk '{print $2}')
		[[ $mute == "yes" ]] && title_emoji="🔇" || title_emoji="🎧"$(pactl list sinks|grep -A 10 \#$sink_id|grep Volume|awk '{print $5}')
	else
		sink_id=$(pactl list sinks short|grep --quiet pci|awk '{print $1}')
		# If mute
		mute=$(pactl list sinks|grep -A 10 \#$sink_id|grep Mute|awk '{print $2}')
		[[ $mute == "yes" ]] && title_emoji="🔇" || title_emoji="🔊"$(pactl list sinks|grep -A 10 \#$sink_id|grep Volume|awk '{print $5}')
	fi
	echo $title_emoji
}

print_date(){
	date '+%m.%d.%Y(%a)'
}

print_time(){
	date '+%H:%M'
}

print_bat(){
	#hash acpi || return 0
	#onl="$(grep "on-line" <(acpi -V))"
	#charge="$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)%"
	#if test -z "$onl"
	#then
		## suspend when we close the lid
		##systemctl --user stop inhibit-lid-sleep-on-battery.service
		#echo -e "${charge}"
	#else
		## On mains! no need to suspend
		##systemctl --user start inhibit-lid-sleep-on-battery.service
		#echo -e "${charge}"
	#fi
	#echo "$(get_battery_charging_status) $(get_battery_combined_percent)%, $(get_time_until_charged )";
	echo "$(get_battery_charging_status)$(get_battery_combined_percent)%";
}

print_brightness(){
	brightness=$(xbacklight -get)
	echo "💡$brightness"
}

print_ram(){
	total_ram=$(free -h|grep Mem|awk '{print $2}')
	used_ram=$(free -h|grep Mem|awk '{print $3}')
	echo "🐏$used_ram:$total_ram"
}

xsetroot -name "$(print_ram) $(get_alsa_output_status) $(print_brightness) $(print_bat) 📆$(print_date) 🕐$(print_time)"
