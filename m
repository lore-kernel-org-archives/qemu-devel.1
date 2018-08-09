Received: from eggs.gnu.org ([2001:4830:134:3::10]:42537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnkGr-00047b-Jf
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnkGo-0006fs-8Z
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:42:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnkGo-0006eh-2K
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:42:26 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-4-e.emanuelegiuseppe@gmail.com>
	<938f8b05-a687-8595-5452-8ec5abf7414c@redhat.com>
	<1c703cc4-644b-1ba8-4ec2-8b58ada7028a@gmail.com>
	<050466ae-69e8-20cd-7484-7da7160deaa9@redhat.com>
	<7a4ad181-f811-7feb-6178-b7d854e102b3@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <91ecb1bc-414e-3957-3b78-3a0c5ff7450d@redhat.com>
Date: Thu, 9 Aug 2018 14:42:23 +0200
MIME-Version: 1.0
In-Reply-To: <7a4ad181-f811-7feb-6178-b7d854e102b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/34] tests/qgraph: pci-pc driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 09/08/2018 14:33, Emanuele wrote:
> Ok, makes sense for qpci_device_init, but I still need to perform that
> check for qpci_device_find.

Yes, you're right.

Thanks,
Laurent
