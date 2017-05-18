Received: from eggs.gnu.org ([2001:4830:134:3::10]:41589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1dBOSS-0005lE-Ol
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1dBOSP-0006Ti-8x
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:39:24 -0400
Received: from sonic310-16.consmr.mail.ir2.yahoo.com ([77.238.177.37]:46585)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1dBOSO-0006TT-TQ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:39:21 -0400
Date: Thu, 18 May 2017 16:39:18 +0000 (UTC)
From: John Bradley <flypie@rocketmail.com>
Reply-To: John Bradley <flypie1@yahoo.com>
Message-ID: <1226435878.1302692.1495125558392@mail.yahoo.com>
In-Reply-To: <87bmqqvc6h.fsf@dusky.pond.sub.org>
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
	<684185116.2952708.1495044580181@mail.yahoo.com>
	<3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
	<107015620.2969780.1495046091978@mail.yahoo.com>
	<5a2b9e50-1444-af4a-dc89-021a4beca0f4@redhat.com>
	<1832071588.99743.1495054408073@mail.yahoo.com>
	<bcff9cd4-3ec2-0757-02e0-96f0e0a7747e@redhat.com>
	<968647832.156883.1495056309814@mail.yahoo.com>
	<d7324134-4eb5-0ca2-2a13-6fd5c5479b49@redhat.com>
	<87bmqqvc6h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom
 Perhiperals for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Geert Martin Ijewski <gm.ijewski@web.de>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

HI,
No worries about Yesterday.
I decided to take a different approach. I'll put that stuff in that relates=
 to GDummyPanel flypie/GDummyPanel first I sent the patch to the list a cop=
y is here. 0001-PATCH-V-2-GDummyPanel-Fix-formatingissues.patch

 =20
| =20
|  =20
|  =20
|   |    |

   |

  |
| =20
|    | =20
0001-PATCH-V-2-GDummyPanel-Fix-formatingissues.patch
 Shared with Dropbox  |   |

  |

  |

=20


Then set about getting the upgrades from Andrew Baumann in.
Then prepare an RFC for the=C2=A0 protocol used by GDummyPanel taking into =
account any feed pack on the prototype/proof of concept/risk reduction in t=
he patch.

 =20
| =20
|  =20
|  =20
|   |    |

   |

  |
| =20
|    | =20
flypie/GDummyPanel
 GDummyPanel - The Client App which links to the Raspi to help simulate GPI=
O  |   |

  |

  |

=20
=C2=A0John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge H=
ill Liverpool L7 7AF=20

    On Thursday, 18 May 2017, 8:47, Markus Armbruster <armbru@redhat.com> w=
rote:
=20

 IANAL, this wouldn't be legal advice even if I was one, yadda, yadda,
here goes anyway:

Eric Blake <eblake@redhat.com> writes:

> On 05/17/2017 04:25 PM, John Bradley wrote:
>> Well unfortunately Eric. I don't understand your "top posted" slang.
>
> To learn what top-posting is:
> http://lmgtfy.com/?q=3Dwhat+is+top-posting
>
> and why we don't like it on technical lists:
> http://www.caliburn.nl/topposting.html
>
> Or more humorously:

Seconded.

> A: Yes.
>> >Q: Are you sure?
>>> >>A: Because it reverses the logical flow of conversation.
>>>> >>>Q: Why is top posting frowned upon?
>
>>=20
>> As for his "intent", it is quite irrelevant as I have gone over the code=
 line by line and what every he intended to do, he has succeed, as far as I=
 can tell , in matching you standards, to such an extent that I am happy th=
at=20
>
> You are correct that the GPL gives us legal rights to use Andrew's code
> without his permission.=C2=A0 And yes, YOU can fork qemu, and take whatev=
er
> GPL patches you want without attribution, and you are probably still
> just fine legally (as long as you still abide by the GPL in that you
> distribute sources to anyone that has your binary).
>
> But our project rules do not allow us to live by just GPL (in part,
> because the license of qemu is sometimes tricky to determine due to a
> mix of GPLv2-only code and non-GPL code, even though most new code is
> GPLv2+).=C2=A0 Also, if we ever had a reason to change license (supposing=
 it
> is even possible, although it might require ripping out or
> reimplementing portions of the code base), having S-o-b means that we
> cannot be accused of applying a license that someone did not agree to.
>
> Therefore, it is easier, pragmatically, even if not legally necessary,
> to enforce proper chain of authorship by getting Signed-off-by: tags on
> ALL patches, especially where a patch asserts a copyright owner, insofar
> as the original copyright owner is still alive and able to assent to the
> action.=C2=A0 It is not just about legalities, it is also about risk-avoi=
dance.
>
> It may sound like we are being hard-nosed (and so be it), but there's a
> reason that we list proper Signed-off-by: rules as our number 1 item on
> the SubmitAPatch page.
> http://wiki.qemu.org/Contribute/SubmitAPatch

Yes, we require patch submitters to provide their Signed-off-by.

We encourage documenting a patch's provenance in full by having every
author provide their S-o-b, whenever practical.=C2=A0 But we don't require
it.

The core purpose of the S-o-b is "to improve tracking of who did what"
by making patch authors formally certify that they "wrote it or
otherwise have the right to pass it on as a open-source patch"[2].=C2=A0 No=
te
"improve" and "have the right to pass it on".

One of the (many) reasons we're making software free is to help our
neighbor[1] by letting him use our creation on a quid pro quo basis.
Always requiring all author's S-o-b could make incorporating otherwise
free code impractical, and thus would conflict with this mission.

When obtaining an S-o-b is impractical, documenting provenance in other
ways has to do.

John wrote upthread:

=C2=A0 =C2=A0 Andrew Baumann has and others have release the code under GNU
=C2=A0 =C2=A0 General Public License version 2 (GPLv2), the same as QEMU th=
at
=C2=A0 =C2=A0 allows me to added it to QEMU as it is under the same license=
, by
=C2=A0 =C2=A0 signing it off this is what I am certifying.

I agree with the reasoning "if free software compatible with the GPLv2,
then I can incorporate it into QEMU as long as I certify by signing
off".

John, thank you for your contribution to QEMU.=C2=A0 I'm sorry your patch g=
ot
side-tracked into this non-technical swamp, and hope you understand why
we're rather careful when it comes to protecting the freedom of our
software.=C2=A0 I futher hope that we can put than behind us (along with
top-posting *grin*), and move on to the fun part.


[1] See "The four essential freedoms"
https://www.gnu.org/philosophy/free-sw.en.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plai=
n/Documentation/process/submitting-patches.rst


  =20
