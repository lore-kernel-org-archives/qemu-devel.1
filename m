Received: from eggs.gnu.org ([2001:4830:134:3::10]:56555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1domdZ-0005mg-QP
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 04:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1domdV-0003ri-QN
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 04:21:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1domdV-0003r1-Jf
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 04:21:37 -0400
Date: Mon, 4 Sep 2017 16:21:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170904082134.GB19748@lemon.lan>
References: <20170903163615.15562-1-n54@gmx.com>
	<150451229313.17979.15505251684262785127@2f78fa2a9cb4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150451229313.17979.15505251684262785127@2f78fa2a9cb4>
Subject: Re: [Qemu-devel] [PATCH] scsi/esp: Rename the ESP symbol to QESP
 (QEMU ESP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: n54@gmx.com, pbonzini@redhat.com

On Mon, 09/04 01:04, no-reply@patchew.org wrote:
> strip "/var/tmp/patchew-tester-tmp-mnp7uu7s/src/install/bin/qemu-system-x86_64"
> strip: elf_update() failed: I/O error: No space left on device

Small swapfs (/tmp), fixing /etc/fstab in the VM.

Fam
