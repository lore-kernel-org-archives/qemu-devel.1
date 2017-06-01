Received: from eggs.gnu.org ([2001:4830:134:3::10]:33117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGPVb-0008Ga-TK
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGPVb-0006qz-8a
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:47:23 -0400
Date: Thu, 1 Jun 2017 20:47:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170601124715.GD13127@lemon.lan>
References: <1492838021-10538-1-git-send-email-ashijeetacharya@gmail.com>
	<1492838021-10538-4-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492838021-10538-4-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/8] vmdk: Rename get_cluster_offset()
 to vmdk_get_cluster_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Sat, 04/22 10:43, Ashijeet Acharya wrote:
> Rename the existing get_cluster_offset() to vmdk_get_cluster_offset()
> and update name in all the callers accordingly.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
