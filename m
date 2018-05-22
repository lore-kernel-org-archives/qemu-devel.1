Received: from eggs.gnu.org ([2001:4830:134:3::10]:53250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5l2-00055g-Oe
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5ky-0007jQ-RF
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:47:12 -0400
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-4-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <851060c5-c731-b706-594c-f52af6da33e4@redhat.com>
Date: Tue, 22 May 2018 13:47:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180522104000.9044-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/5] hw/s390x: Rename 2.13
 machines to 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 22.05.2018 12:39, Peter Maydell wrote:
> Rename the 2.13 machines to match the number we're going to
> use for the next release.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/s390x/s390-virtio-ccw.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
