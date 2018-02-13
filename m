Received: from eggs.gnu.org ([2001:4830:134:3::10]:51072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elWoq-0000uO-Ha
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 04:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elWol-0000Dm-Ku
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 04:24:08 -0500
Date: Tue, 13 Feb 2018 10:23:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180213102339.440ec621.cohuck@redhat.com>
In-Reply-To: <20180212154903.8859-1-dgilbert@redhat.com>
References: <20180212154903.8859-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390/stattrib: Make SaveVMHandlers data
 static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, david@redhat.com, qemu-s390x@nongnu.org

On Mon, 12 Feb 2018 15:49:03 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> There's no need for this to be dynamic, make it static.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/s390x/s390-stattrib.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Thanks, applied.
