Received: from eggs.gnu.org ([2001:4830:134:3::10]:39488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fW4N9-0007bv-JC
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fW4N6-0001Po-Gf
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fW4N6-0001Or-AQ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:31:52 -0400
Date: Thu, 21 Jun 2018 15:31:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180621183148.GX7451@localhost.localdomain>
References: <1529443919-67509-1-git-send-email-babu.moger@amd.com>
	<1529443919-67509-4-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529443919-67509-4-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v16 3/3] i386: Remove generic SMT thread
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, mtosatti@redhat.com, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Tue, Jun 19, 2018 at 05:31:59PM -0400, Babu Moger wrote:
> Remove generic non-intel check while validating hyperthreading support.
> Certain AMD CPUs can support hyperthreading now.
> 
> CPU family with TOPOEXT feature can support hyperthreading now.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued, thanks!

-- 
Eduardo
