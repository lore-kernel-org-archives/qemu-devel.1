Received: from eggs.gnu.org ([2001:4830:134:3::10]:55076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLopF-00033q-Ev
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLopC-0000p6-8m
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:54:33 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:38465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fLopC-0000ou-2P
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:54:30 -0400
Received: by mail-wr0-x234.google.com with SMTP id 94-v6so2586140wrf.5
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 04:54:29 -0700 (PDT)
References: <09ACC28F0266D94FB9D1BC3F193A6478014E3D1B@MX303CL02.corp.emc.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <7bc63c59-de50-dbeb-dee8-bca3e6dd12cd@gmail.com>
Date: Thu, 24 May 2018 14:54:25 +0300
MIME-Version: 1.0
In-Reply-To: <09ACC28F0266D94FB9D1BC3F193A6478014E3D1B@MX303CL02.corp.emc.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
To: "Wei, Aaron" <Aaron.Wei@Dell.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Fu, Bryan" <Bryan.Fu@dell.com>, "Xia, Robert" <Robert.Xia@dell.com>, "Zhou, Zhenzan" <Zhenzan.Zhou@dell.com>, Zihan Yang <whois.zihan.yang@gmail.com>

Hi Aaron

On 05/24/2018 12:31 PM, Wei, Aaron wrote:
>
> Hi,  Marcel
>
> It's my pleasure to write to you on behalf of a team who is developing 
> the Intel VMD virtualization base on QEMU in Dell EMC.
>
> From https://www.outreachy.org. we find that you are working on the 
> Multiple PCI domain feature which we think may be  very helpful to our 
> current work.
>

We are glad you are considering using the project.
The project got delayed for next "Outreachy/GSOC" round, however Zihan 
Yang <whois.zihan.yang@gmail.com>,
a PhD student, graciously offered to try it in his private time.

> We’ll be grateful if you can share some information about,
>
> 1.What’s the present developing status?
>

An early RFC (not a working version) was posted here:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04664.html
The mail thread includes an interesting discussion on issues and constrains.

> 2.When would it possibly be ready? Or when could we get it from QEMU repo?
>

Since is currently developed as a side project we don't have a clear 
timeline,
you are welcome to contribute with ideas, reviews, tests and patches :) .
Any help is appreciated.

> We appreciate and  look forward to your reply.
>

I hope I helped.

Thanks,
Marcel
>
> Best wishes,
>
> Aaron Wei
>
