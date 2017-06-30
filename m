Received: from eggs.gnu.org ([2001:4830:134:3::10]:59999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dQyWM-0002XK-MX
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dQyWH-0000hM-LO
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:11:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40449
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dQyWH-0000h6-EG
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:11:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5UG93FS077952
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 12:11:44 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bdm0w7ces-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 12:11:43 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 30 Jun 2017 17:11:41 +0100
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-2-pasic@linux.vnet.ibm.com>
	<20170607095127.GB2099@work-vm>
	<8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
	<f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
	<00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
	<2791f136-d531-464c-8c44-7006ff7a658f@linux.vnet.ibm.com>
	<c28ab7f2-4541-4657-0387-b988e8040e3f@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 18:10:49 +0200
MIME-Version: 1.0
In-Reply-To: <c28ab7f2-4541-4657-0387-b988e8040e3f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pNonC1qOX2sAaIVlnIhCSWEWCJxwcs90L"
Message-Id: <7fdfeb7c-050b-1cf4-e22a-fa242da99ad9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed
 equal checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pNonC1qOX2sAaIVlnIhCSWEWCJxwcs90L
From: Halil Pasic <pasic@linux.vnet.ibm.com>
To: Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Jason J . Herne" <jjherne@linux.vnet.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Message-ID: <7fdfeb7c-050b-1cf4-e22a-fa242da99ad9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed equal
 checks
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
 <20170606165510.33057-2-pasic@linux.vnet.ibm.com>
 <20170607095127.GB2099@work-vm>
 <8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
 <f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
 <00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
 <2791f136-d531-464c-8c44-7006ff7a658f@linux.vnet.ibm.com>
 <c28ab7f2-4541-4657-0387-b988e8040e3f@redhat.com>
In-Reply-To: <c28ab7f2-4541-4657-0387-b988e8040e3f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/30/2017 04:54 PM, Eric Blake wrote:
> On 06/30/2017 09:41 AM, Halil Pasic wrote:
>>>> 'This' basically boils down to the question and
>>>> 'Why aren't hints reported in QMP context?'
>>>
>>> QMP is supposed to be machine-parseable.  Hints are supposed to be
>>> human-readable. If you have a machine managing the monitor, the hint
>>> adds nothing but bandwidth consumption, because machine should not be=

>>> parsing the human portion of the error message in the first place (as=
 it
>>> is, libvirt already just logs the human-readable portion of a message=
,
>>> and bases its actions solely on the machine-stable portions of an err=
or
>>> reply: namely, whether an error was sent at all, and occasionally, wh=
at
>>> error class was used for that error - there's no guarantee a human wi=
ll
>>> be reading the log, though).
>>
>>
>> Seems I've made wrong assumptions about error messages (in QEMU) up un=
til
>> now. If I understand you correctly, in QEMU error messages are part of=

>> the API (but hints are not). Thus if one changes a typo in an error
>> message (like here
>> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06732.html) t=
he
>> one is strictly speaking breaking API backward compatibility.  Is that=

>> really the way we want to have things?
>=20
> Quite the opposite. In QMP, the EXISTENCE of an error message is part o=
f
> the API, but the CONTENTS of the message are not (machines are not
> supposed to further parse the message) - anything that the machine woul=
d
> want to differentiate between two different possible error messages
> should instead be conveyed via a second field in the same returned
> dictionary (the error class), and not by parsing the message. =20

I think we are in agreement, it's just that you call 'error message' what=

I would call 'error response' (from docs/qmp-spec.txt). For me an error
response MAY OR MAY NOT or MUST (I don't know it is not stated in
qmp-spec.txt, and qapi-schema.json did not make me much smarter: I would
guess may or may not -- there is even some comment in qapi-schema showing=

it that direction) contain a 'desc' which is per definition "- The
"desc" member is a human-readable error message. Clients should not
attempt to parse this message.".

So I would call that 'error message'. If the logic (modulo reporting) in
libvirt (I don't know, my focus isn't libvirt) or any other management
software depends on the EXISTENCE of 'desc' (or human-readable portion of=

some error API object) I find that weird, but it's a definition thing.


> Most
> often, there is not a strong case for having differentiation, so most
> errors are lumped in the generic class (error_setg() makes this easy to=

> do by default).  An example where differentiation matters: look at the
> "Important Note" in blockdev.c:qmp_block_commit().

I think I have seen that. I find the 'strong discouragement' weird, becau=
se
if there is a reason to have differentiation the error class is the way
to go. And if there is no reason to -- it should be obvious.

>=20
>>
>> From prior experiences I'm more used to think about error messages as
>> something meant for human consumption, and expressing things expected =
to
>> be relevant for some kind of client code in a different way (optimized=

>> for machine consumption).
>>
>> If however the error message ain't part of the machine relevant portio=
n,
>> then the same argument applies as to the 'hint', and I don't see the
>> reason for handling hints differently. Do you agree with my
>> argumentation?
>=20
> Indeed, it may not hurt to start passing the hints over the wire (error=
s
> would then consume more bandwidth, but errors are not the hot path).
> And I'm not necessarily opposed to that change, so much as trying to
> document why it is not currently the case.  At the same time, I probabl=
y
> won't be the one writing a path to populate the hint information into
> the QMP error, as I don't have any reason to use the hint when
> controlling libvirt (except maybe for logging, but there, the hint is
> not going to help the end user, because it's not the end-user's fault
> that libvirt used the API wrong to get a hint in the first place).

For me both human readable things make sense only for error reporting
(effectively logging). Error.msg should IMHO be different, than Error.hin=
t.
The existence of an error should be indicated by the Error object.

>=20
>=20
>>> If something absolutely must be reported, then it is not a hint, and
>>> shouldn't be using the hint mechanism.
>>>
>>
>> I find it hard to formulate criteria for 'must be reported'. I'm afrai=
d
>> this is backwards logic: since the hint may not be reported everything=

>> that needs to be reported is not a hint. This is a valid approach of
>> course, but then I think some modifications to the comments in error.h=

>> would not hurt. And maybe something with verbose would be more
>> expressive name.
>>
>> I hope all this makes some sense and ain't pure waste of time...
>=20
> No, it never hurts to question whether the design is optimal, and it's
> better to question first to know whether it is even worth patching
> things to behave differently, rather than spending time patching it onl=
y
> to have a maintainer clarify that the patch can't be accepted because o=
f
> some design constraint.  So I still hope Markus will chime in.
>=20

For this patch I went with Dave's proposal so I have no acute interest
in changing this.

Conceptually, for me it really boils down to the question: Is it reasonab=
le
to assume that we are interested in what went wrong (error message)?

If yes, we are good as is. If no, we should not drop hint in QMP context.=


Thanks for your time. I think we provided Markus with enough input to
make his call :).

Halil


--pNonC1qOX2sAaIVlnIhCSWEWCJxwcs90L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJZVng5AAoJEA0vhuyXGx0Au1EP/iRmT9lYkYH43Slxod4q8Dh0
Pphdcg7oMjdc6XqvkNg4UkdqopMEwyxzonI07sMBrlNShYgAnU+3oebNAqHWti3f
Q8u3uawqoqrN/piFCM9CDMYOH8VYJrLCJRFonahgXkCePccBevBW8H9Hy327Ohpr
/sOCyT7lq21geonMKWap1i7xcgOXZSRle6NPA2zJ4/GkpGLbsUzQKkOVkwJDlKx+
Gg5RHE/D4zpcqpNg2+s9+nl3cDslu1oY6NdQ123lezcN2wgLIl3W+LntfRgLB+3t
MJsi+GjWNExFDVxbLdaFrViFxp0gXvLfVKiVvW0Fni1EmUVMSPkaCDoZWUWQ01iU
p4mnFrGqwKRBsfrRJzznZE0zU3RPBvS8q1Cg7ASA92jF/IrVjQ5+cL76pqHA4hPn
DH83pbpvBOnWF/RNJCPDD0790h7rtlJOhJNT4kz17Uo845CmpsoRoAOGTbTX8d9L
ng6f1xfVAs0KOAUcxFRc4jjUo86aeyGvGihAyrjvJj8Ih6g0WVo0XWxjznthdOEh
bUW/UG7jGl4zfk0enV68hHumSAowsH5RRSWy3agu3+9b3uYV/ZZpBlZvM1clyIqS
dI6/X3ScW8F8nzdL8h49PUZ4bzDaudfVeDVWZ8VxIqLLxzFYmkGXokda+gbX8wnM
Yd5qBTtLY/oPfhUjfqPD
=mtHR
-----END PGP SIGNATURE-----

--pNonC1qOX2sAaIVlnIhCSWEWCJxwcs90L--
