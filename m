Received: from eggs.gnu.org ([2001:4830:134:3::10]:39470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1GZM-00037k-Hc
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1GZL-0001wE-G9
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:12:40 -0400
References: <20170419222258.13415-1-eblake@redhat.com>
	<87k26fffxa.fsf@dusky.pond.sub.org> <20170420120922.GJ20955@redhat.com>
	<1f4e72ed-fab1-7099-768e-2a111df3a633@redhat.com>
	<87r30n83d1.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <65718a2d-c866-09a9-b60c-69a6b9a263fd@redhat.com>
Date: Thu, 20 Apr 2017 13:12:19 -0500
MIME-Version: 1.0
In-Reply-To: <87r30n83d1.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="30j48tWkATCMtRibvP1ewUFpnIoeIFhgu"
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Scott Wood <scottwood@freescale.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>, Cor nelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--30j48tWkATCMtRibvP1ewUFpnIoeIFhgu
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:Overall" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Scott Wood <scottwood@freescale.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring
 <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair.francis@xilinx.com>,
 "open list:Calxeda Highbank" <qemu-arm@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Cor nelia Huck <cornelia.huck@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <65718a2d-c866-09a9-b60c-69a6b9a263fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to SHUTDOWN
References: <20170419222258.13415-1-eblake@redhat.com>
 <87k26fffxa.fsf@dusky.pond.sub.org> <20170420120922.GJ20955@redhat.com>
 <1f4e72ed-fab1-7099-768e-2a111df3a633@redhat.com>
 <87r30n83d1.fsf@dusky.pond.sub.org>
In-Reply-To: <87r30n83d1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 11:12 AM, Markus Armbruster wrote:

>>> Well technically /usr/sbin/halt just terminates all processes / kerne=
l and
>>> halts CPUs, but the virtual machine is still active (and a 'reset' in=
 the
>>> monitor can start it again. /usr/sbin/poweroff is what actually does =
the
>>> ACPI poweroff to trigger QEMU to exit[1]
>>
>> I'm thinking of this wording:
>>
>> triggered by a guest request (such as the guest running
>> /usr/sbin/poweroff to trigger an ACPI shutdown or machine halt instruc=
tion)
>=20
> A quick glance at the patch suggests the instructions in question are
> typically writes to some device register.  I wouldn't call them "halt
> instructions", in particular since there's the x86 "hlt" instruction
> that does something else.

Then maybe: a guest request (such as the guest running
/usr/sbin/poweroff to trigger an ACPI or other hardware-specific
shutdown sequence)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--30j48tWkATCMtRibvP1ewUFpnIoeIFhgu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+PoDAAoJEKeha0olJ0NqInsH/1pcxnHBUPsEeRlLCD2Z78MC
1oHlpynEqi/qskZ2R/V1xPziwCKKyq/n6XplCn743NZ9mq8fp7cV9pvkdh0HbmyW
zCaSum4FcBRsoyClfBd9SZd6KowRpbYNdvT023naU84ppRvwSkdkxraMT4Vv+9/f
/N4wXenMxPl/dxaFL3E/n9cXDggXQM+C0j4Sl1vf25pAMnCZhDt2nyM/KCiBzt+q
FFH1DfJVO0E6WL+c25q5FmZz4BL6CYRYh50neQxAcTT89GhPQbpGyd8aFvlDbTqi
VAGdfTJNgD2nRKXShoDeAEGgh9b8QyA2eb+76W+aaGsQkYnO5x1Qh+qYuLWy15Y=
=18eE
-----END PGP SIGNATURE-----

--30j48tWkATCMtRibvP1ewUFpnIoeIFhgu--
