Received: from eggs.gnu.org ([209.51.188.92]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqcjI-00074F-5n
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqcj9-00052w-3D
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:47:51 -0500
Date: Mon, 4 Feb 2019 12:47:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204124739.4fd62065.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-15-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-15-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/15] s390-bios: Add channel command
 codes/structs needed for dasd-ipl
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

On Tue, 29 Jan 2019 08:29:21 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> The dasd IPL procedure needs to execute a few previously unused
> channel commands. Let's define them and their associated data
> structures.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Acked-by: Cornelia Huck <cohuck@redhat.com>
