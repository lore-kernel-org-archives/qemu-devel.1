Received: from eggs.gnu.org ([2001:4830:134:3::10]:45407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cQeiM-0004zA-Hg
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 13:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cQeiH-0006nV-FV
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 13:30:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34638
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cQeiH-0006n1-8Z
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 13:30:33 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v09IStEa001426
	for <qemu-devel@nongnu.org>; Mon, 9 Jan 2017 13:30:31 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27vde5efpq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 13:30:31 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 9 Jan 2017 18:30:29 -0000
References: <1469611466-31574-1-git-send-email-silbe@linux.vnet.ibm.com>
	<57991CC1.40003@redhat.com> <87twfaysit.fsf@dusky.pond.sub.org>
	<5799E26B.7090408@linux.vnet.ibm.com> <579A1D33.6010500@redhat.com>
	<579A24BE.2060707@linux.vnet.ibm.com> <579A733C.5050306@redhat.com>
	<579B5C49.1040707@linux.vnet.ibm.com>
	<8b7d3287-90c4-6a07-894c-e9c32fd4567f@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 9 Jan 2017 19:27:17 +0100
MIME-Version: 1.0
In-Reply-To: <8b7d3287-90c4-6a07-894c-e9c32fd4567f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lvFsk9mL00xWLKPccr6bL4drlLQgc7SPV"
Message-Id: <e1305993-ac60-d965-16cd-281919825ff6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] error: error_setg_errno(): errno gets
 preserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lvFsk9mL00xWLKPccr6bL4drlLQgc7SPV
From: Halil Pasic <pasic@linux.vnet.ibm.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>,
 Sascha Silbe <silbe@linux.vnet.ibm.com>
Message-ID: <e1305993-ac60-d965-16cd-281919825ff6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] error: error_setg_errno(): errno gets
 preserved
References: <1469611466-31574-1-git-send-email-silbe@linux.vnet.ibm.com>
 <57991CC1.40003@redhat.com> <87twfaysit.fsf@dusky.pond.sub.org>
 <5799E26B.7090408@linux.vnet.ibm.com> <579A1D33.6010500@redhat.com>
 <579A24BE.2060707@linux.vnet.ibm.com> <579A733C.5050306@redhat.com>
 <579B5C49.1040707@linux.vnet.ibm.com>
 <8b7d3287-90c4-6a07-894c-e9c32fd4567f@redhat.com>
In-Reply-To: <8b7d3287-90c4-6a07-894c-e9c32fd4567f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/09/2017 03:50 PM, Eric Blake wrote:
> On 07/29/2016 08:38 AM, Halil Pasic wrote:
>>
>>
>> On 07/28/2016 11:03 PM, Eric Blake wrote:
>>> On 07/28/2016 09:29 AM, Halil Pasic wrote:
>>>
>>>>> You mean va_start, not start_va.  And actually, C11 is clear that e=
rrno
>>>>> is unspecified after library functions (but not macros) that don't
>>>>> explicitly state otherwise.  Since va_start() is a macro and not a
>>>>> library function, that means va_start does NOT have carte blanche
>>>>> permission to modify errno.  For more reading on the topic:
>>>>
>>>> I also considered this function/macro thing but in the end I am not
>>>> aware of anything in C11 what would prohibit va_start to modify errn=
o --
>>>> correct me if I'm wrong. With that it boils down to 'may' and relyin=
g on
>>>> 'does not' means you are not covered by the standard C11 (but may
>>>> be covered by something else -- in which case this should be documen=
ted
>>>> in HACKING).
>>>>
>>>>>
>>>>> http://austingroupbugs.net/view.php?id=3D384
>>>>>
>>>>
>>>> This got rejected, or? Means that there is no willingness to introdu=
ce
>>>> this guarantee at POSIX level?
>>>> =20
>>>
>>> That particular bug report was rejected because the POSIX folks decid=
ed
>>> that the C11 wording was clear enough that va_start() was already
>>> guaranteed to not mess with errno, so no additionally wording was nee=
ded
>>> in POSIX.
>>>
>>
>> Sadly, I still do not get it. I have re-read the relevant parts of N15=
70
>> and even had a conversation with the in house compiler team. The
>> compiler guy's opinion was also that there is no guarantee provided by=

>> C11. In http://austingroupbugs.net/view.php?id=3D384 you stated in the=

>> description that the code example provided there is not conforming.
>=20
> The description was the initial claim, before I had consulted with the
> rest of the Austin Group.  Yes, my initial claim was that POSIX needed
> tightening to guarantee something not provided by C.
>=20
>> Your
>> last reply I read like you were wrong with that statement.
>=20
> Correct - after consultation with the full Austin Group, my initial
> claim was invalidated, and the reason it was invalidated was that the
> C99 standard only permits arbitrary changes to errno after function
> calls, and that the C99 definition of a function call does NOT include
> macro expansions.  Therefore, POSIX does not need tightening, because
> the guarantee I wanted is already present; the initial description in
> that bug report is well-defined, rather than my claim of undefined.
> Any compliant C implementation, and therefore all POSIX-compliant
> implementations, already leave errno unchanged after any use of the
> varags macros.  (The current version of POSIX is still stuck on C99,
> although the Austin Group is just barely starting work to incorporate
> C11 for the next version of POSIX.)
>=20
>> I still do
>> not understand why were you wrong there. In fact, I could argue that y=
ou
>> were right, but I'm afraid the argument would be somewhat lengthy and
>> confusing, and I'm already feeling bad about taking so much of your ti=
me
>> with this. Since I'm  admittedly quite inexperienced in this field I
>> decided to just accept your the conclusion you and the POSIX guys
>> reached -- without fully understanding it.
>=20
> The C99 standard is annoying in that it does not use the usual RFC
> wording, so where C99 uses "may", many other standards (including POSIX=
)
> use "shall" or even "shall only".  So the fact that C99 states that "Th=
e
> value of errno may be set to nonzero by a library function call" is a
> requirement that C can permit arbitrary modification of errno ONLY afte=
r
> a function call, and not for any other reason (including after a macro

Thanks for the clarification. As a non-native speaker I find that usage
of "may" highly non-intuitive. Especially since in chapter 4.
"Conformance" (from n1124) does define how "shall" and "shall not" but
there is nothing on "may".

This way of saying macros expand to stuff that does not touch errno is
IMHO quite unfriendly (if this was really the intention - I think it is
quite likely that it was), and IMHO a more straight forward formulation
would benefit the standard.

> expansion if that macro does not expand to a documented function call).=


It's clear that macro expansion itself does not modify program state, so
the question is to what is a library macro allowed to expand to.

> va_start() is usually not implemented as a function call, and even if i=
t
> is, it is not a publicly documented function call.

IMHO whether it is implemented as a function (call) or a macro is irrelev=
ant
here. Apparently library functions may be additionally implemented as a m=
acro,
and library macros may be implemented as functions (7.2 "The assert macro=

shall  be  implemented  as  a  macro,  not  as  an  actual  function").

Library macros can expand to stuff calling documented library functions
(7.2.1.1 "It then calls the abort function."), but this is also
irrelevant if we interpret that "may" as you explained.=20


>=20
> But you are certainly welcome to add further comments to the Austin
> Group bug, if you think anything was misinterpreted - in the end, the
> intent IS that va_* are safe to use without arbitrary changes to errno,=

> and it is now just a matter of whether that intent is already met by C
> wording or whether POSIX indeed needs to add an additional requirement.=

>=20

Thank you very much for making your point clear. I take away: "The value
of errno may be set to nonzero by a library function call" also
means/implies 'use of any library entity, which was not specified as a
library function, shall not set errno to nonzero'.  This really helps me
a lot because it answers the question which part of the standard
prohibits the va_* macros from clobbering errno.

I see this primarily as a C ISO standard problem, so I'm reluctant to
necro-bump that bug in order to start a discussion about how the C
standard is to be interpreted.  I'm going to ask some friends if it is
only me who finds it difficult to read that sentence as you propose.


Best Regards,
Halil


=20


--lvFsk9mL00xWLKPccr6bL4drlLQgc7SPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJYc9bAAAoJEA0vhuyXGx0AQeAP/RnbzASguqiMBwZI04pffxZp
fulphtJv7Qel78IIHUHLBluY85BJqNWjJqgmXIkkEjYPZvfmmI6mkvZi6gSgicP5
li23AkBPYT6WQJX1FqUi/hHPSSRUuZJgSDPGarzRsYH0wbvcjf5Kcyr4CPJfBGJx
RdOWk4hZw/odBE+KGU5gMHBySRhQ4s0oeBSmiNbEUnhzDtXo8+VB16SA0G03eTt7
Kxud0VXBTxGFRuNZYPWBamv4d8imw/Aesqc6uI2+h4Ccgg+pChl6os3S+tAH3PLD
eC9tlz3TmEf0EOp7IeAi4W4AWLlV2V/9PWBg0WG0GyT9cxpbRevDXT1uerzUpt6f
RDohB4O4sUbX7N0odwfVdBtrNomAgnHBCsnGI5JMxKwNo6q7LLpBdYubXS2r4WsP
itxei/LM4rl18cG4OlIGLJvnn2zpzlye8y7sLSuu1yC3JE3cROboGwixunaa+LMv
4FAE2nBlFXFeY4B+SaJ6EKQzoUkYjjlHBY4tzX10v2kchydDsVpG1Cn9MGtlzyf1
uKx3sU8SryAeTP2Ko3JY2eBG+LRvS2AXLG/BJzVbqjtzDqaqJGll9JaDW9Dc31mn
xZ/4ByBo3fp4wkTPDuIf/jkBRAsmqPuO85LY8sB7begTKermmos83bKAEP9iyIQs
SXuW+Q1Ji8yLiGMkngpy
=EmJA
-----END PGP SIGNATURE-----

--lvFsk9mL00xWLKPccr6bL4drlLQgc7SPV--
