Received: from eggs.gnu.org ([2001:4830:134:3::10]:42330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc8Tz-0005Pt-Ps
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc8Tw-0001GY-Jc
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:31:15 -0500
Date: Fri, 10 Feb 2017 11:31:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170210113108.6798be14@nial.brq.redhat.com>
In-Reply-To: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] pc/spapr: unify handling of possible
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: drjones@redhat.com, ehabkost@redhat.com, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>

On Thu,  9 Feb 2017 12:08:31 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

[...]
> 
> Series depends on:
>   [PATCH 0/3] spapr: fix cpu core hotunplug call flow
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg427214.html
> which is staged for next pull req in SPAPR tree.

David,

could you merge it through your ppc tree as this series
depends on above patches that are there but not in master yet.


[...]
