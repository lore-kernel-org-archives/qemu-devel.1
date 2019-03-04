Received: from eggs.gnu.org ([209.51.188.92]:59998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0rJb-0007Y3-3Z
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0rJa-0001Qs-HF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:23:47 -0500
Date: Mon, 4 Mar 2019 18:23:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190304182340.056e0d7d.cohuck@redhat.com>
In-Reply-To: <1551466776-29123-7-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-7-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/16] s390-bios: Clean up cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Fri,  1 Mar 2019 13:59:26 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Add proper typedefs to all structs and modify all bit fields to use consistent
> formatting.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.h      | 152 ++++++++++++++++++++++----------------------
>  pc-bios/s390-ccw/s390-ccw.h |   8 ---
>  2 files changed, 76 insertions(+), 84 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
