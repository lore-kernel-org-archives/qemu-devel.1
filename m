Received: from eggs.gnu.org ([2001:4830:134:3::10]:44347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSTps-0003jW-V8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSTpo-0001Yo-3V
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSTpn-0001Ya-TI
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:54:40 -0400
Date: Mon, 11 Jun 2018 17:54:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611205433.GY7451@localhost.localdomain>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-2-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528498581-131037-2-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v13 1/5] i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Fri, Jun 08, 2018 at 06:56:17PM -0400, Babu Moger wrote:
> Add support for cpuid leaf CPUID_8000_001E. Build the config that closely
> match the underlying hardware. Please refer to the Processor Programming
> Reference (PPR) for AMD Family 17h Model for more details.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Queued on x86-next, thanks.

-- 
Eduardo
