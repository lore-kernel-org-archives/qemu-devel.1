Received: from eggs.gnu.org ([2001:4830:134:3::10]:60890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxxfj-0006Qp-OH
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 11:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxxfj-0002so-0M
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 11:57:51 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:46830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dxxfi-0002rG-QF
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 11:57:50 -0400
Received: by mail-wm0-x22f.google.com with SMTP id m72so406426wmc.1
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 08:57:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b9f89dc4-35fc-7d27-6ec7-d131d4be5b06@redhat.com>
References: <20170926122427.GC4115@localhost.localdomain>
	<20170926130028.12471-1-ehabkost@redhat.com>
	<890a01d9-d7a0-6afd-ffac-5c8f2425570f@de.ibm.com>
	<b9f89dc4-35fc-7d27-6ec7-d131d4be5b06@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Sep 2017 08:57:28 -0700
Message-ID: <CAFEAcA9iX+CCKNdP9Nk4__mOU-wimbi86z62aZkgr8qHwXOpZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] iothread: Make iothread_stop() idempotent
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On 29 September 2017 at 07:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 29/09/2017 15:47, Christian Borntraeger wrote:
>> Is anybody going to pick this up? upstream qemu is still happily filling
>> up my disk with coredumps on exit.
>
> I can, but I'll only send the pull request next Monday, probably.

I'm not likely to be able to apply any pull requests til Monday anyway :-)

thanks
-- PMM
