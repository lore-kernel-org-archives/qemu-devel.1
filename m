Received: from eggs.gnu.org ([2001:4830:134:3::10]:52432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1HOd-0003cJ-Ik
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1HOc-0001Up-Fb
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:05:39 -0400
References: <20170419222258.13415-1-eblake@redhat.com>
	<87k26fffxa.fsf@dusky.pond.sub.org>
	<1adf2797-b86a-00be-bb98-658ee8d0a55d@redhat.com>
	<87lgqv833h.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53bc367e-df07-be34-25c5-dbf0b3ee174e@redhat.com>
Date: Thu, 20 Apr 2017 14:05:18 -0500
MIME-Version: 1.0
In-Reply-To: <87lgqv833h.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vH7BL4FPskm3aeOscikoBnikhExPXU7iL"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, Scott Wood <scottwood@freescale.com>, Richard Henderson <rth@twiddle.net>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vH7BL4FPskm3aeOscikoBnikhExPXU7iL
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Overall" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring
 <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair.francis@xilinx.com>,
 "open list:Calxeda Highbank" <qemu-arm@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Scott Wood <scottwood@freescale.com>, Richard Henderson <rth@twiddle.net>,
 Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Yongbok Kim <yongbok.kim@imgtec.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <53bc367e-df07-be34-25c5-dbf0b3ee174e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to SHUTDOWN
References: <20170419222258.13415-1-eblake@redhat.com>
 <87k26fffxa.fsf@dusky.pond.sub.org>
 <1adf2797-b86a-00be-bb98-658ee8d0a55d@redhat.com>
 <87lgqv833h.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgqv833h.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 11:18 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 04/20/2017 06:59 AM, Markus Armbruster wrote:
>>
>>>
>>> No objection to Alistair's idea to turn this into an enumeration.
>>
>> Question - should the enum be more than just 'guest' and 'host'?  For
>> example, my patch proves that we have a lot of places that handle
>> complimentary machine commands to reset and shutdown, and that whether=

>> 'reset' triggers a reset (and the guest keeps running as if rebooted) =
or
>> a shutdown is then based on the command-line arguments given to qemu.
>> So having the enum differentiate between 'guest-reset' and
>> 'guest-shutdown' would be a possibility, if we want the enum to have
>> additional states.
>=20
> I don't know.  What I do know is that we better get the enum right:
> while adding members is backwards-compatible, changing the member sent
> for a specific trigger is not.  If we want to reserve the option to do
> that anyway, we need suitable documentation.

Or even this idea:

{ 'enum': 'ShutdownCause', 'data': [ 'shutdown', 'reset', 'panic' ] }
{ 'event': 'SHUTDOWN',
  'data': { 'guest': 'bool', '*cause': 'ShutdownCause' } }

where the enum can grow as we come up with ever more reasons worth
exposing (maybe even 'qmp', 'gui' and 'interrupt' are reasonable causes
for a host shutdown).  Our promise would be that 'guest' never changes
for an existing shutdown reason, but that 'cause' may become more
refined over time if someone expresses a need for having the distinction.=


Thoughts?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vH7BL4FPskm3aeOscikoBnikhExPXU7iL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+QZuAAoJEKeha0olJ0Nq8eoH/15t11zZAIQvrpYBnHxxlwUb
ThZ7v0LVQ0cnKvf685HivxtchYmBaikvo380r/yphov4/kuatI6QWkV/Hke+YHaV
+BnxkvI3G6HoyVZvRTWNWi5t7L5dY4PNDrAYySWmBwS1N0h4l8YogTXCq26BMhJo
5BbFL04YCn9jF2K/ZS+gTFd/Y8fHw9AG+OdiCS3IKAgriuz4+6EDH+Dd6ul6icux
0oHgMBCXIu6E8+7YIPEgdNUpVP8hlcMXeCsBC6aHsHk7cXKdEzKseu7k4lq+7aga
P60tbxjkCWLhfmRoqfoEkjEVfBFEvXuJ0qOxvWs6sF9iIsQHm3DFnavk8C4TCOA=
=JX4c
-----END PGP SIGNATURE-----

--vH7BL4FPskm3aeOscikoBnikhExPXU7iL--
