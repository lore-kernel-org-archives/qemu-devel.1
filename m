Received: from eggs.gnu.org ([2001:4830:134:3::10]:50547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1erShz-0001mQ-6V
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1erShu-0000eH-W0
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:13:35 -0500
Received: from mx.cs.uchicago.edu ([128.135.164.214]:37284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <huaicheng@cs.uchicago.edu>)
	id 1erShu-0000e3-OU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:13:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.cs.uchicago.edu (Postfix) with ESMTP id C45B55FE0A
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 12:13:29 -0600 (CST)
Received: from mx.cs.uchicago.edu ([127.0.0.1])
	by localhost (mx.cs.uchicago.edu [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id p08ob2iMxmKQ for <qemu-devel@nongnu.org>;
	Thu,  1 Mar 2018 12:13:29 -0600 (CST)
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com
	[209.85.217.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.cs.uchicago.edu (Postfix) with ESMTPSA id 0406C5FAA4
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 12:13:29 -0600 (CST)
Received: by mail-ua0-f171.google.com with SMTP id c14so4470530uak.7
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 10:13:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227163551.GF32480@stefanha-x1.localdomain>
References: <CANr0WEcfzA7aibMaGeKC2RVr=s2g0z4-R6ZaSjKtRFQiSu4XLQ@mail.gmail.com>
	<473ee14f-a202-d283-afdf-01bb8d4d84e4@redhat.com>
	<CANr0WEc6F0_-bKgG4EMgBCpMsw7t6sx_fV=A1VXqnzDzu51Qyw@mail.gmail.com>
	<1cace15b-81b7-0217-72f9-92e451f370a3@redhat.com>
	<20180227163551.GF32480@stefanha-x1.localdomain>
From: Huaicheng Li <huaicheng@cs.uchicago.edu>
Date: Thu, 1 Mar 2018 12:12:44 -0600
Message-ID: <CANr0WEexCCzfRWsr=34vje5mW-8N=sm42tyccA=_CEDuROFtOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU GSoC 2018 Project Idea (Apply polling to QEMU
 NVMe)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Stefan,

Paolo and I have filled the template. And Paolo has helped update the wiki
with this proposed project idea.

Thanks.

Best,
Huaicheng


On Tue, Feb 27, 2018 at 10:35 AM, Stefan Hajnoczi <stefanha@gmail.com>
wrote:

> On Tue, Feb 27, 2018 at 12:04:48PM +0100, Paolo Bonzini wrote:
> > On 27/02/2018 10:05, Huaicheng Li wrote:
> > > Great to know that you'd like to mentor the project! If so, can we
> make it
> > > an official project idea and put it on QEMU GSoC page?
> >
> > Submissions need not come from the QEMU GSoC page.  You are free to
> > submit any idea that you think can be worthwhile.
>
> Please follow the process described here:
>
> https://wiki.qemu.org/Google_Summer_of_Code_2018#How_to_
> propose_a_custom_project_idea
>
> The project idea needs to be posted on the wiki page.
>
> Huaicheng & Paolo, please fill out this template so we can add it to the
> wiki page:
>
> === TITLE ===
>
>  '''Summary:''' Short description of the project
>
>  Detailed description of the project.
>
>  '''Links:'''
>  * Wiki links to relevant material
>  * External links to mailing lists or web sites
>
>  '''Details:'''
>  * Skill level: beginner or intermediate or advanced
>  * Language: C
>  * Mentor: Email address and IRC nick
>  * Suggested by: Person who suggested the idea
>
