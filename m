Received: from eggs.gnu.org ([2001:4830:134:3::10]:39146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fLzB8-0002l9-Bg
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fLzB7-0004Wt-5v
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:57:50 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:52134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fLzB6-0004Wf-Uj
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:57:49 -0400
Received: by mail-wm0-x22c.google.com with SMTP id j4-v6so9430032wme.1
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:57:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7bc63c59-de50-dbeb-dee8-bca3e6dd12cd@gmail.com>
References: <09ACC28F0266D94FB9D1BC3F193A6478014E3D1B@MX303CL02.corp.emc.com>
	<7bc63c59-de50-dbeb-dee8-bca3e6dd12cd@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Fri, 25 May 2018 06:57:46 +0800
Message-ID: <CAKwiv-iEcONujdm_DjOM0at=UFBuNsXOktZ1AKa1f=ewCtb60Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU: Multiple PCI domains for x86 PCI Express
 Machine (Q35)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Aaron.Wei@dell.com, "Fu, Bryan" <Bryan.Fu@dell.com>, "Xia, Robert" <Robert.Xia@dell.com>, "Zhou,
	Zhenzan" <Zhenzan.Zhou@dell.com>

2018-05-24 19:54 GMT+08:00 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>:
> Hi Aaron
>
> On 05/24/2018 12:31 PM, Wei, Aaron wrote:
>>
>>
>> Hi,  Marcel
>>
>> It's my pleasure to write to you on behalf of a team who is developing t=
he
>> Intel VMD virtualization base on QEMU in Dell EMC.
>>
>> From https://www.outreachy.org. we find that you are working on the
>> Multiple PCI domain feature which we think may be  very helpful to our
>> current work.
>>
>
> We are glad you are considering using the project.
> The project got delayed for next "Outreachy/GSOC" round, however Zihan Ya=
ng
> <whois.zihan.yang@gmail.com>,
> a PhD student, graciously offered to try it in his private time.

Hi Marcel

Thank you for CCing and mentioning me in the email. I'm really glad to know
people are interested in the project. It is really a joy to contribute
to it. By the
way, I'm currently a master student but that doesn't matter here.

>> We=E2=80=99ll be grateful if you can share some information about,
>>
>> 1.What=E2=80=99s the present developing status?
>>
>
> An early RFC (not a working version) was posted here:
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04664.html
> The mail thread includes an interesting discussion on issues and constrai=
ns.
>
>> 2.When would it possibly be ready? Or when could we get it from QEMU rep=
o?
>>
>
> Since is currently developed as a side project we don't have a clear
> timeline,
> you are welcome to contribute with ideas, reviews, tests and patches :) .
> Any help is appreciated.

Hi Aaron

Thanks for your interest, I wish I could finish it as soon as
possible, but I'm afraid
I can't give any guarantee right now. As Marcel said, we don't have a
clear timeline
yet. The official project lasts 12 weeks, and I plan to finish it
before September.
The pace might be faster after June when all the exams are finished.

About the project itself, we actually just started yet. You might want
to look at the
initial patch set I submitted a few days ago, as posted by Marcel in
the last email.
These patches are just POC, asking for reviews and comments. The AML part i=
n
QEMU and the firmware part are not implemented yet. I get many good reviews
from Marcel and other members, and am preparing for a v2 patch.

Actually, even if I finish all the work, there still might be some
time before the
patches are available in the upstream because there will be reviews
and comments,
and they are likely to go through many versions before they are merged.

>> We appreciate and  look forward to your reply.
>>
>
> I hope I helped.

I hope I helped too :)
Feel free to comment/review/email/contribute if you have any questions abou=
t
this project.

Thanks
Zihan
