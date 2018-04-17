Received: from eggs.gnu.org ([2001:4830:134:3::10]:41423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8XuU-0006VB-NV
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8XuR-00024i-I8
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8XuR-0001ye-C7
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:13:03 -0400
Date: Tue, 17 Apr 2018 18:12:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180417211254.GF29865@localhost.localdomain>
References: <1523991487-241006-1-git-send-email-mst@redhat.com>
	<1523991487-241006-3-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523991487-241006-3-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] include/standard-headers: add
 asm-x86/kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Wanpeng Li <kernellwp@gmail.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>

On Tue, Apr 17, 2018 at 09:58:25PM +0300, Michael S. Tsirkin wrote:
> Import asm-x86/kvm_para.h from linux where it can
> be easily used on Linux and non-Linux platforms.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
