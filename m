Received: from eggs.gnu.org ([2001:4830:134:3::10]:42958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkcHC-0008Ev-J5
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkcH7-000894-Mg
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:29:22 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dkcH7-00088l-GN
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:29:17 -0400
Received: by mail-wm0-f41.google.com with SMTP id l19so6833810wmi.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 13:29:17 -0700 (PDT)
References: <d2c54be0-8eec-9b6f-63e3-c31e487bc7f3@adacore.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3cf9e9c9-3320-46c2-b8d7-2e77986863d4@redhat.com>
Date: Wed, 23 Aug 2017 22:29:14 +0200
MIME-Version: 1.0
In-Reply-To: <d2c54be0-8eec-9b6f-63e3-c31e487bc7f3@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] RFC: qemu RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>, sw-dev@groups.riscv.org
Cc: kbastian@mail.uni-paderborn.de

On 23/08/2017 21:25, KONRAD Frederic wrote:
> Hi all,
> 
> I found somes slides about RISC-V at the KVM forum 2016.
> 
> Seems the upstreaming process should have started in september 2016 but
> I didn't see anything.
> 
> Is that still planed?

We're waiting from the privileged interface specification to become stable.

The linux-user emulation could go in now (for some value of now), but
the RISC-V people wanted to have the system emulation first.

Paolo
