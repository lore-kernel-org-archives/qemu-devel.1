Received: from eggs.gnu.org ([2001:4830:134:3::10]:41251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coYGD-0005Tq-Lp
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coYGC-00027k-DL
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:28:21 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coYGC-00027c-6i
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:28:20 -0400
Received: by mail-wm0-x233.google.com with SMTP id u132so39660855wmg.0
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:28:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316161649.GZ15193@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316161649.GZ15193@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 16:27:58 +0000
Message-ID: <CAFEAcA8Y8Hafsd7mixyDExbMtBdcAx4t=LRR3_-MGqBNHKADAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 March 2017 at 16:16, Daniel P. Berrange <berrange@redhat.com> wrote:
> BTW, by "build & test system available", presumably you mean a system
> that someone has committed to actively maintaining, not merely donation
> of (or access to) hardware on which to install & run VMs ?

My personal minimum is "something I can ssh into to run the build
scripts". Hardware maintained by somebody else is ideal (eg
anything in the gcc compile farm). I don't object to VMs as long
as somebody else is setting up and maintaining them...

thanks
-- PMM
