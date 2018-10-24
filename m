Received: from eggs.gnu.org ([2001:4830:134:3::10]:47866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFG4u-0006Gf-Rz
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFG4q-0008LL-2W
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:07:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gFG4p-0008KY-S3
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:07:47 -0400
Date: Wed, 24 Oct 2018 06:49:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181024094928.GB4096@habkost.net>
References: <1539578845-37944-1-git-send-email-robert.hu@linux.intel.com>
	<1539578845-37944-2-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539578845-37944-2-git-send-email-robert.hu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/3] kvm: Add support to
 KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS system ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, robert.hu@intel.com, qemu-devel@nongnu.org

On Mon, Oct 15, 2018 at 12:47:23PM +0800, Robert Hoo wrote:
> Add kvm_get_supported_feature_msrs() to get supported MSR feature index list.
> Add kvm_arch_get_supported_msr_feature() to get each MSR features value.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
