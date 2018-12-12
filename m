Received: from eggs.gnu.org ([2001:4830:134:3::10]:54969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX6To-0007RS-HM
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX6Ti-0007MI-Ab
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:31:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gX6Ti-0007Ll-3o
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:31:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so6160268wmc.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:31:14 -0800 (PST)
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <333ef314-6389-4159-eaeb-f49bbdc011ee@redhat.com>
Date: Wed, 12 Dec 2018 16:31:11 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/71] qtest: qgraph driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 12/3/18 4:32 PM, Paolo Bonzini wrote:
>   tests: qgraph API for the qtest driver framework
>   tests/libqos: pci-pc driver and interface nodes
>   tests/libqos: x86_64/pc machine node
>   tests/libqos: sdhci driver and interface nodes
>   tests/libqos: arm/raspi2 machine node
>   tests/libqos: arm/smdkc210 machine node
>   tests/libqos: arm/sabrelite machine node
>   tests/libqos: arm/xilinx-zynq-a9 machine node
>   tests/libqos: aarch64/xlnx-zcu102 machine node
>   qos-test: sdhci test node

For the previous patches:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
