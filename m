Received: from eggs.gnu.org ([2001:4830:134:3::10]:38026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFnMX-0001dK-4X
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFnMT-0004oM-R1
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:08:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFnMT-0004o1-M6
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:07:57 -0400
Date: Mon, 7 May 2018 18:07:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507210747.GI13350@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-9-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760009-24710-9-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 8/9] i386: Enable TOPOEXT feature on AMD
 EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, geoff@hostfission.com, kash@tripleback.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, Apr 26, 2018 at 11:26:48AM -0500, Babu Moger wrote:
> Enable TOPOEXT feature on EPYC CPU. This is required to support
> hyperthreading on VM guests. Also extend xlevel to 0x8000001E.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
