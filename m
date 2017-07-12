Received: from eggs.gnu.org ([2001:4830:134:3::10]:39051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVIzd-0001gk-8z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVIzZ-0003tQ-8W
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVIzZ-0003t6-2j
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:51:53 -0400
Date: Wed, 12 Jul 2017 16:51:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712165146.525b699e@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499864265-144136-7-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-7-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/11] s390x/cpumodel: provide compat
 handling for new cpu features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

On Wed, 12 Jul 2017 14:57:40 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Provide a mechanism to disable features in compatibility machines.

User to come in the next batch of patches?

> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c | 26 ++++++++++++++++++++++++++
>  target/s390x/cpu_models.h |  2 ++
>  2 files changed, 28 insertions(+)

Acked-by: Cornelia Huck <cohuck@redhat.com>
