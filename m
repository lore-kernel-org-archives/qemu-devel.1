Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D4C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 10:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1E82072B
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 10:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1E82072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mrbrklyn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKgGe-000675-8c
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 06:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ruben@mrbrklyn.com>) id 1jKdMT-000344-En
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 03:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ruben@mrbrklyn.com>) id 1jKdMR-0004WW-Mm
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 03:37:01 -0400
Received: from www2.mrbrklyn.com ([96.57.23.82]:42699 helo=mrbrklyn.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ruben@mrbrklyn.com>)
 id 1jKdMR-0004UN-HL; Sat, 04 Apr 2020 03:36:59 -0400
Received: from stat37.mrbrklyn.com (www.mrbrklyn.com [96.57.23.83])
 by mrbrklyn.com (Postfix) with ESMTP id 46ED6163FA2;
 Sat,  4 Apr 2020 03:36:58 -0400 (EDT)
Date: Sat, 04 Apr 2020 00:37:53 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <de4b6733-859b-eebe-32ab-c0eb0fcb6311@redhat.com>
References: <de92e66d-c474-dd1b-ddab-194b2f92d1dd@redhat.com>
 <de4b6733-859b-eebe-32ab-c0eb0fcb6311@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----PAWDPBAK5OCFZ4YLF5Z1RM678HM6N6"
Content-Transfer-Encoding: 7bit
Subject: Re: QEMU participation to Google Season of Docs
To: qemu-discuss@nongnu.org, John Snow <jsnow@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Weil <sw@weilnetz.de>
From: Ruben <ruben@mrbrklyn.com>
Message-ID: <834E48D0-E9DE-41DC-8E40-3657FB69698C@mrbrklyn.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 96.57.23.82
X-Mailman-Approved-At: Sat, 04 Apr 2020 06:42:18 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------PAWDPBAK5OCFZ4YLF5Z1RM678HM6N6
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Its ingoogle=2E=2E=2E We don't do google=2E



On April 3, 2020 9:37:09 PM EDT, John Snow <jsnow@redhat=2Ecom> wrote:
>
>
>On 4/1/20 12:37 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi,
>>=20
>> Google recently announced their 'Season of Docs' project:
>> https://developers=2Egoogle=2Ecom/season-of-docs
>>=20
>> QEMU project seems to fit all the requirements=2E
>>=20
>> Who is interested in [co-]mentoring?
>>=20
>> Relevant links:
>> https://developers=2Egoogle=2Ecom/season-of-docs/docs/admin-guide
>> https://developers=2Egoogle=2Ecom/season-of-docs/docs/timeline
>>=20
>> [Following is extracted from the previous links:]
>>=20
>> Example projects:
>>=20
>> * Build a documentation site on a platform to be decided
>> =C2=A0 by the technical writer and open source mentor, and publish
>> =C2=A0 an initial set of basic documents on the site=2E Examples of
>> =C2=A0 platforms include:
>>=20
>> =C2=A0 - A static site generator such as Hugo, Jekyll, Sphinx, =2E=2E=
=2E
>>=20
>> * Refactor the open source project's existing documentation to
>> =C2=A0 provide an improved user experience or a more accessible
>> =C2=A0 information architecture=2E
>>=20
>> * Write a conceptual overview of, or introduction to, a product
>> =C2=A0 or feature=2E Often a team creates their technical documentation
>> =C2=A0 from the bottom up, with the result that there's a lot of
>> =C2=A0 detail but it's hard to understand the product as a whole=2E A
>> =C2=A0 technical writer can fix this=2E
>>=20
>> * Create a tutorial for a high-profile use case=2E
>>=20
>> * Create a set of focused how-to guides for specific tasks=2E
>>=20
>> * Create a contributor=E2=80=99s guide that includes basic information
>> =C2=A0 about getting started as a contributor to the open source
>> =C2=A0 project, as well as any rules around licence agreements,
>> =C2=A0 processes for pull requests and reviews, building the project,
>> =C2=A0 and so on=2E
>>=20
>> Previous experience with similar programs, such as Google Summer
>> of Code or others: If you or any of your mentors have taken part
>> in Google Summer of Code or a similar program, mention this in
>> your application=2E Describe your achievements in that program=2E
>> Explain how this experience may influence the way you work in
>> Season of Docs=2E
>>=20
>> The 2020 season of Season of Docs is limited to a maximum of
>> 50 technical writing projects in total=2E
>> As a guideline, we expect to accept a maximum of 2 projects
>> per organization, so that we don't end up with too many
>> accepted projects=2E However, if the free selection process
>> doesn't fill all the slots, the Google program administrators
>> may allocate additional slots to some organizations=2E
>>=20
>
>This looks like it could be very good for us=2E
>
>My only concern is that the scope and breadth of QEMU is huge and it
>may
>be a lot for a newcomer to tackle appropriately for top-level docs, so
>I
>feel like it requires a mentor who has a good understanding of the
>broad
>picture of QEMU=2E
>
>Like the description says, we often write things bottom-up in areas of
>very specific focus=2E The broad picture is sometimes harder to conjure
>accurately=2E
>
>I have a lot of opinions and thoughts on python and how docs should be
>laid out, but I'm afraid I'm not so good at understanding all of the
>options and "use cases" of QEMU to confidently lay out a top-level TOC=2E
>Maybe if we collaborated on a TOC we could give a clear project
>guideline to a GSoC/GSoD contributor=2E
>
>(Or maybe I'm overthinking it=2E)
>
>--js

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
------PAWDPBAK5OCFZ4YLF5Z1RM678HM6N6
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Its ingoogle=2E=2E=2E We don't do google=2E<br><br=
><br><br><div class=3D"gmail_quote">On April 3, 2020 9:37:09 PM EDT, John S=
now &lt;jsnow@redhat=2Ecom&gt; wrote:<blockquote class=3D"gmail_quote" styl=
e=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">
<pre class=3D"k9mail"><br><br>On 4/1/20 12:37 PM, Philippe Mathieu-Daud=C3=
=A9 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1e=
x 0=2E8ex; border-left: 1px solid #729fcf; padding-left: 1ex;">Hi,<br><br>G=
oogle recently announced their 'Season of Docs' project:<br><a href=3D"http=
s://developers=2Egoogle=2Ecom/season-of-docs">https://developers=2Egoogle=
=2Ecom/season-of-docs</a><br><br>QEMU project seems to fit all the requirem=
ents=2E<br><br>Who is interested in [co-]mentoring?<br><br>Relevant links:<=
br><a href=3D"https://developers=2Egoogle=2Ecom/season-of-docs/docs/admin-g=
uide">https://developers=2Egoogle=2Ecom/season-of-docs/docs/admin-guide</a>=
<br><a href=3D"https://developers=2Egoogle=2Ecom/season-of-docs/docs/timeli=
ne">https://developers=2Egoogle=2Ecom/season-of-docs/docs/timeline</a><br><=
br>[Following is extracted from the previous links:]<br><br>Example project=
s:<br><br>* Build a documentation site on a platform to be decided<br>&nbsp=
; by the technical writer and open source mentor, and publish<br>&nbsp; an =
initial set of basic documents on the site=2E Examples of<br>&nbsp; platfor=
ms include:<br><br>&nbsp; - A static site generator such as Hugo, Jekyll, S=
phinx, =2E=2E=2E<br><br>* Refactor the open source project's existing docum=
entation to<br>&nbsp; provide an improved user experience or a more accessi=
ble<br>&nbsp; information architecture=2E<br><br>* Write a conceptual overv=
iew of, or introduction to, a product<br>&nbsp; or feature=2E Often a team =
creates their technical documentation<br>&nbsp; from the bottom up, with th=
e result that there's a lot of<br>&nbsp; detail but it's hard to understand=
 the product as a whole=2E A<br>&nbsp; technical writer can fix this=2E<br>=
<br>* Create a tutorial for a high-profile use case=2E<br><br>* Create a se=
t of focused how-to guides for specific tasks=2E<br><br>* Create a contribu=
tor=E2=80=99s guide that includes basic information<br>&nbsp; about getting=
 started as a contributor to the open source<br>&nbsp; project, as well as =
any rules around licence agreements,<br>&nbsp; processes for pull requests =
and reviews, building the project,<br>&nbsp; and so on=2E<br><br>Previous e=
xperience with similar programs, such as Google Summer<br>of Code or others=
: If you or any of your mentors have taken part<br>in Google Summer of Code=
 or a similar program, mention this in<br>your application=2E Describe your=
 achievements in that program=2E<br>Explain how this experience may influen=
ce the way you work in<br>Season of Docs=2E<br><br>The 2020 season of Seaso=
n of Docs is limited to a maximum of<br>50 technical writing projects in to=
tal=2E<br>As a guideline, we expect to accept a maximum of 2 projects<br>pe=
r organization, so that we don't end up with too many<br>accepted projects=
=2E However, if the free selection process<br>doesn't fill all the slots, t=
he Google program administrators<br>may allocate additional slots to some o=
rganizations=2E<br><br></blockquote><br>This looks like it could be very go=
od for us=2E<br><br>My only concern is that the scope and breadth of QEMU i=
s huge and it may<br>be a lot for a newcomer to tackle appropriately for to=
p-level docs, so I<br>feel like it requires a mentor who has a good underst=
anding of the broad<br>picture of QEMU=2E<br><br>Like the description says,=
 we often write things bottom-up in areas of<br>very specific focus=2E The =
broad picture is sometimes harder to conjure<br>accurately=2E<br><br>I have=
 a lot of opinions and thoughts on python and how docs should be<br>laid ou=
t, but I'm afraid I'm not so good at understanding all of the<br>options an=
d "use cases" of QEMU to confidently lay out a top-level TOC=2E<br>Maybe if=
 we collaborated on a TOC we could give a clear project<br>guideline to a G=
SoC/GSoD contributor=2E<br><br>(Or maybe I'm overthinking it=2E)<br><br>--j=
s<br><br></pre></blockquote></div><br>-- <br>Sent from my Android device wi=
th K-9 Mail=2E Please excuse my brevity=2E</body></html>
------PAWDPBAK5OCFZ4YLF5Z1RM678HM6N6--

