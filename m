Received: from eggs.gnu.org ([2001:4830:134:3::10]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7jim-0007tn-1d
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7jig-0001dR-9n
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:33:08 -0400
References: <20170505193810.2934-1-eblake@redhat.com>
	<20170505193810.2934-4-eblake@redhat.com>
	<20170508052617.GC25748@umbus.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <117db2fa-302b-362a-738c-0c114439f8af@redhat.com>
Date: Mon, 8 May 2017 09:32:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170508052617.GC25748@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eJaV9TWHqeWL3RiuGaBs5V0dHviTnHgX7"
Subject: Re: [Qemu-devel] [PATCH v6 3/5] shutdown: Add source information to
 SHUTDOWN and RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Burton <paul.burton@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Stefan Weil <sw@weilnetz.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Marcelo Tosatti <mtosatti@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Old World" <qemu-ppc@nongnu.org>, "open list:Overall" <kvm@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eJaV9TWHqeWL3RiuGaBs5V0dHviTnHgX7
From: Eric Blake <eblake@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 alistair.francis@xilinx.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 Andrzej Zaborowski <balrogg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Burton <paul.burton@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Magnus Damm <magnus.damm@gmail.com>, Michael Walle <michael@walle.cc>,
 Max Filippov <jcmvbkbc@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "open list:Calxeda Highbank" <qemu-arm@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 "open list:Old World" <qemu-ppc@nongnu.org>,
 "open list:Overall" <kvm@vger.kernel.org>
Message-ID: <117db2fa-302b-362a-738c-0c114439f8af@redhat.com>
Subject: Re: [PATCH v6 3/5] shutdown: Add source information to SHUTDOWN and
 RESET
References: <20170505193810.2934-1-eblake@redhat.com>
 <20170505193810.2934-4-eblake@redhat.com>
 <20170508052617.GC25748@umbus.fritz.box>
In-Reply-To: <20170508052617.GC25748@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 12:26 AM, David Gibson wrote:
> On Fri, May 05, 2017 at 02:38:08PM -0500, Eric Blake wrote:
>> Time to wire up all the call sites that request a shutdown or
>> reset to use the enum added in the previous patch.
>>
>> It would have been less churn to keep the common case with no
>> arguments as meaning guest-triggered, and only modified the
>> host-triggered code paths, via a wrapper function, but then we'd
>> still have to audit that I didn't miss any host-triggered spots;
>> changing the signature forces us to double-check that I correctly
>> categorized all callers.
>>
>> Since command line options can change whether a guest reset request
>> causes an actual reset vs. a shutdown, it's easy to also add the
>> information to reset requests.
>>
>> Replay adds a FIXME to preserve the cause across the replay stream,
>> that will be tackled in the next patch.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au> [ppc parts]
>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [SPARC p=
art]
>=20
> [snip]
>=20
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 9f18f75..2735fe9 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1166,7 +1166,7 @@ static target_ulong h_client_architecture_suppor=
t(PowerPCCPU *cpu,
>>      spapr_ovec_cleanup(ov5_updates);
>>
>>      if (spapr->cas_reboot) {
>> -        qemu_system_reset_request();
>> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>=20
> I'm not 100% sure about this one, since I'm not sure 100% of how the
> different enum values are defined.  This one is tripped when feature
> negotiation between firmware and guest can't be satisfied without
> rebooting (next time round the firmware will use some different
> options).

Patch 2/5 introduced the enum.  The biggest part of the patch (for now)
is that anything SHUTDOWN_CAUSE_HOST_ will be exposed to the QMP client
as host-triggered, anything SHUTDOWN_CAUSE_GUEST_ will be exposed as
guest-triggered.  I basically used SHUTDOWN_CAUSE_GUEST_RESET for any
call to qemu_system_reset_requst() underneath the hw/ tree, because the
hw/ tree is emulating guest behavior and therefore it is presumably a
reset caused by a guest request.

>=20
> So it's essentially a firmware/hypervisor triggered reset, but one
> that should only ever be tripped during early guest boot.  Is
> CAUSE_GUEST_RESET correct for that?

Of course, I'm not an export on SPAPR, so I'll happily change it to
anything else if you think that is more appropriate. But the rule of
thumb I went by is whether this is qemu emulating a bare-metal
reset/shutdown, vs. qemu killing the guest without waiting for guest
instructions to reach some magic
memory/register/ACPI/who-knows-what-else request.  While it may happen
only early during guest boot, it is still the guest firmware that is
requesting it, and not qemu causing a unilateral death.

>=20
> Apart from this, ppc changes
>=20
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Thanks.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eJaV9TWHqeWL3RiuGaBs5V0dHviTnHgX7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEIGKAAoJEKeha0olJ0NqFUAH/2b8f/o4s8hHefg41wGxezZb
A/JVuE4gus9lM/B2Nrl5GgA32JQVDjLtXlty2jcZRrdfFA7TOwVXREaAwThe+F/O
Y2su6qeNcuSLbdN3SL4ygiPDSmuZwaS4b6sDtE94MOaj1zCNkqtd713i/AP4xWDy
2ZRR+SOIbl/CKP6n83aZTDLjI9gGZOZiE/g1BLCz6c/y2QWKvHVFtEmkTb//m9yJ
LUWwTiP3LV40z5FRq+gjpE+G0V+wb2JqE5UGd24Fau4M4e9dWyIhwH7+hulkv9E7
anGqjLdYhNDGnnz8jCvXo4DBYjiY0DdnhlVOHuvdUlcSVIp1n99/QpmkdjrR5Ws=
=fXNm
-----END PGP SIGNATURE-----

--eJaV9TWHqeWL3RiuGaBs5V0dHviTnHgX7--
