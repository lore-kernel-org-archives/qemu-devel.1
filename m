Received: from eggs.gnu.org ([2001:4830:134:3::10]:59004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK7G5-0007dR-So
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK7Fy-0003ES-E0
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:43:25 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK7Fv-0002kK-93
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:43:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id t15-v6so5618127wmt.0
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 11:43:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14afff40-6f99-06af-ceea-f2dba6b45a13@redhat.com>
Date: Tue, 6 Nov 2018 20:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 06/11/2018 19:43, Peter Maydell wrote:
> hw/pci/shpc.c ?

This is not a device, it is a PCI capability.

Paolo
