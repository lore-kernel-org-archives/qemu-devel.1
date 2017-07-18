Received: from eggs.gnu.org ([2001:4830:134:3::10]:55035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXOuV-0008WM-8C
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXOuR-0007YL-6n
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:35:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXOuQ-0007YB-Vf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:35:15 -0400
Date: Tue, 18 Jul 2017 11:35:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170718113502.55e7e03f@gondolin>
In-Reply-To: <1500369144-143949-3-git-send-email-borntraeger@de.ibm.com>
References: <1500369144-143949-1-git-send-email-borntraeger@de.ibm.com>
	<1500369144-143949-3-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/2] s390x/cpumodel: z14 cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

On Tue, 18 Jul 2017 11:12:24 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> This patch introduces the CPU model for z14, along with all base and
> optional features.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c   |  1 +
>  target/s390x/gen-features.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

FWIW:

Acked-by: Cornelia Huck <cohuck@redhat.com>
