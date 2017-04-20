Received: from eggs.gnu.org ([2001:4830:134:3::10]:36931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1CBP-0005xK-14
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1CBN-0002oz-IC
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:31:39 -0400
References: <20170419222258.13415-1-eblake@redhat.com>
	<87k26fffxa.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1adf2797-b86a-00be-bb98-658ee8d0a55d@redhat.com>
Date: Thu, 20 Apr 2017 08:31:13 -0500
MIME-Version: 1.0
In-Reply-To: <87k26fffxa.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rvogOOC9M8Qchv8Tmi1DsIOcOodRm5gnm"
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rvogOOC9M8Qchv8Tmi1DsIOcOodRm5gnm
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "open list:Overall" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring
 <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair.francis@xilinx.com>,
 "open list:Calxeda Highbank" <qemu-arm@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <1adf2797-b86a-00be-bb98-658ee8d0a55d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to SHUTDOWN
References: <20170419222258.13415-1-eblake@redhat.com>
 <87k26fffxa.fsf@dusky.pond.sub.org>
In-Reply-To: <87k26fffxa.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 06:59 AM, Markus Armbruster wrote:

>=20
> No objection to Alistair's idea to turn this into an enumeration.

Question - should the enum be more than just 'guest' and 'host'?  For
example, my patch proves that we have a lot of places that handle
complimentary machine commands to reset and shutdown, and that whether
'reset' triggers a reset (and the guest keeps running as if rebooted) or
a shutdown is then based on the command-line arguments given to qemu.
So having the enum differentiate between 'guest-reset' and
'guest-shutdown' would be a possibility, if we want the enum to have
additional states.


>> +++ b/vl.c
>> @@ -1717,7 +1717,7 @@ void qemu_system_guest_panicked(GuestPanicInform=
ation *info)
>>      if (!no_shutdown) {
>>          qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
>>                                         !!info, info, &error_abort);
>> -        qemu_system_shutdown_request();
>> +        qemu_system_shutdown_request(false);
>=20
> Panicking is a guest action.  Whether the shutdown on panic should be
> attributed to guest or host is perhaps debatable.

And it relates to the idea that a guest request for a 'reset' turns into
a qemu response of 'shutdown'.  After all, whether a guest panic results
in a shutdown action is determined by command-line arguments to qemu.
So if we DO want to differentiate between a guest panic and a normal
guest shutdown, when both events are wired at the command line to cause
the SHUTDOWN action, then that's another enum to add to my list.


>> +++ b/replay/replay.c
>> @@ -51,7 +51,10 @@ bool replay_next_event_is(int event)
>>          switch (replay_state.data_kind) {
>>          case EVENT_SHUTDOWN:
>>              replay_finish_event();
>> -            qemu_system_shutdown_request();
>> +            /* TODO: track source of shutdown request, to replay a
>> +             * guest-initiated request rather than always claiming to=

>> +             * be from the host? */
>> +            qemu_system_shutdown_request(false);
>=20
> This is what your "need a followup patch" refers to.  I'd like to have
> an opinion from someone familiar with replay on what exactly we need
> here.

replay-internal.h has an enum ReplayEvents, which is a list of one-byte
codes used in the replay data stream to record which event to replay. I
don't know if it is easier to change the replay stream to add a 2-byte
code (shutdown-with-cause, followed by an encoding of the cause enum),
or a range of one-byte codes (one new code per number of enum members).
I also don't know how easy or hard it is to extend the enum (are we free
to add events in the middle, or are we worried about back-compat to an
older replay stream that must still play correctly with a newer qemu,
such that new events must be higher than all existing events).

So yes, I'm hoping for feedback from someone familiar with replay.

>=20
> Amazing number of ways to shut down or reset a machine.

And as I said, it would be easier to submit a patch with less churn by
having the uncommon case (host-triggered) call a new
qemu_system_shutdown_request_reason(enum), while the common case
(guest-triggered) be handled by having qemu_system_shutdown_request()
with no arguments call
qemu_system_shutdown_request_reason(SHUTDOWN_GUEST).  I'm just worried
that doing it that way makes it easy for yet another new host shutdown
method to use the wrong wrapper.

>=20
> Looks sane on first glance.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rvogOOC9M8Qchv8Tmi1DsIOcOodRm5gnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+LghAAoJEKeha0olJ0NqDt8IAIrnTV7Mwg28cND2x9q3CyEM
xBNQKsByD/aE87wf8Au0NWGtzlfa5DhEHbqqMhPBO+QHUQfa0l9Go44h5HXUKmy/
dmm+X/9ow24Ujuf8ARxFIGJacPB7L7hSGxJdeIw853qIxlh6RNIW91plyZKn/FVa
O8hSosbP4+YiDT0p/yKVtt1e4h3fZ1WD0YFWFUTkIruJcABCPmYHyRPkSHNClkAq
rPnd3/Kk+D1HpvGXF6aAfXp7/flBcDvpp4b1qgxe086zMjL/beMkfwAIJNMlFZQ+
nKLWFfi9uRwkGUYUIwOOtxvCcK+EBU8dww7ZUTt/xEmONlIzHUtQVAS1XVTJ7/g=
=qNfk
-----END PGP SIGNATURE-----

--rvogOOC9M8Qchv8Tmi1DsIOcOodRm5gnm--
