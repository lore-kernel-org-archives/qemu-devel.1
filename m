Received: from eggs.gnu.org ([2001:4830:134:3::10]:41545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8YjF-0006cn-OT
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8YjD-0002l5-4q
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:05:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8YjC-0002iM-Uy
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:05:31 -0400
Date: Tue, 17 Apr 2018 19:05:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180417220524.GH29865@localhost.localdomain>
References: <1523991487-241006-1-git-send-email-mst@redhat.com>
	<1523991487-241006-5-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523991487-241006-5-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] linux-headers: drop kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Wanpeng Li <kernellwp@gmail.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Tue, Apr 17, 2018 at 09:58:37PM +0300, Michael S. Tsirkin wrote:
> Unused now and can be removed.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
