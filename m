Received: from eggs.gnu.org ([2001:4830:134:3::10]:34698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1C0d-0002Nc-7n
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1C0c-0006nQ-6r
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:20:31 -0400
References: <20170419222258.13415-1-eblake@redhat.com>
	<87k26fffxa.fsf@dusky.pond.sub.org> <20170420120922.GJ20955@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f4e72ed-fab1-7099-768e-2a111df3a633@redhat.com>
Date: Thu, 20 Apr 2017 08:20:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170420120922.GJ20955@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MJ1tsuo055DBeRBh8xXxl1H5JDCn29vB7"
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, Scott Wood <scottwood@freescale.com>, Richard Henderson <rth@twiddle.net>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MJ1tsuo055DBeRBh8xXxl1H5JDCn29vB7
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
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
Message-ID: <1f4e72ed-fab1-7099-768e-2a111df3a633@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to SHUTDOWN
References: <20170419222258.13415-1-eblake@redhat.com>
 <87k26fffxa.fsf@dusky.pond.sub.org> <20170420120922.GJ20955@redhat.com>
In-Reply-To: <20170420120922.GJ20955@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 07:09 AM, Daniel P. Berrange wrote:

>>> +++ b/qapi/event.json
>>> @@ -10,6 +10,10 @@
>>>  # Emitted when the virtual machine has shut down, indicating that qe=
mu is
>>>  # about to exit.
>>>  #
>>> +# @guest: If true, the shutdown was triggered by a guest request (su=
ch as
>>> +# executing a halt instruction) rather than a host request (such as =
sending
>>> +# qemu a SIGINT). (since 2.10)
>>> +#
>>
>> "executing a halt instruction" suggests "halt" is a machine instructio=
n.

Which is indeed what most of the places I patched to pass 'true' are
emulating - the machine halt instruction.

>> I think you mean /usr/sbin/halt.  Suggest something like "executing a
>> halt command".
>=20
> Well technically /usr/sbin/halt just terminates all processes / kernel =
and
> halts CPUs, but the virtual machine is still active (and a 'reset' in t=
he
> monitor can start it again. /usr/sbin/poweroff is what actually does th=
e
> ACPI poweroff to trigger QEMU to exit[1]

I'm thinking of this wording:

triggered by a guest request (such as the guest running
/usr/sbin/poweroff to trigger an ACPI shutdown or machine halt instructio=
n)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MJ1tsuo055DBeRBh8xXxl1H5JDCn29vB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+LWLAAoJEKeha0olJ0NqMFMIAJ+mxZJviG+ZHLY7f0P+nZHw
lSmYS3rDIUtpTlg/L41kGp2qaa/4Le0Dm8SjVIOcfXH0Q0ZF9Lz2D5TKdJpOwCpO
9xI2aJTR2T5VZS8eiV4Cwb58EnwCkm2V0xSTigug1B3/mc0HjNyrCrIBmoenXGy9
svhwYAkIi4uJoLqvEPBa3b97TUYgCNcYFLewAEwehQv5eYyaveMLJ0Gn7srfS2tb
8eRhZca425Y47DQWX6W6n3YHQSvRkKgPuuIR03dd6comUBYREJzkE4cwUPCRdPut
QaJocb0qiCjL+tSQe104bffeBeuQmnymmSbIdEC7C+Y5M5BXsg6k8//VARsBmhw=
=qiAs
-----END PGP SIGNATURE-----

--MJ1tsuo055DBeRBh8xXxl1H5JDCn29vB7--
