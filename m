Received: from eggs.gnu.org ([2001:4830:134:3::10]:53917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ewM97-00040U-At
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 02:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ewM91-0000vT-0F
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 02:13:49 -0400
Date: Thu, 15 Mar 2018 11:43:30 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20180314180140.GB4764@localhost.localdomain>
Message-ID: <nycvar.YSQ.7.76.1803151136060.7879@wniryva>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<20180314172351.GA4764@localhost.localdomain>
	<7F85C9E4-D04F-474C-A8E3-2EAFC5B864B9@oracle.com>
	<20180314180140.GB4764@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] CVE-2018-7550 (was: multiboot: bss_end_addr can be
 zero / cleanup)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jack Schwartz <jack.schwartz@oracle.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ppandit@redhat.com, qemu-stable@nongnu.org

+-- On Wed, 14 Mar 2018, Kevin Wolf wrote --+
| Well, it seems to me that this patch was created for a different
| purpose, but it happens to fix the bug for which this CVE was assigned
| now.

  Right. I had sent another patch to fix it, there Jack mentioned about his 
series from before.
 
| I think PJP knew that this CVE was coming before the patches were merged
| into master, so if he had told us, we could have had a better commit
| message.

  For non-embargoed issues we request CVE from Mitre after a proposed patch is 
reviewed and acked for upstream QEMU. Nevertheless, going forward I'll mention 
the CVE-ID here on the list, as soon as it is assigned.

| I don't think a problem like this would be embargoed at all.

  True.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
