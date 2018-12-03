Received: from eggs.gnu.org ([2001:4830:134:3::10]:52798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTsne-0000Kz-Rv
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTsnZ-0000fP-UX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:18:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gTsnZ-0000eo-M7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:18:25 -0500
References: <20181203100608.28538-1-jasowang@redhat.com>
	<20181203100608.28538-3-jasowang@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <da253555-57f4-971e-8a12-88a085140397@redhat.com>
Date: Mon, 3 Dec 2018 19:18:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181203100608.28538-3-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 for 3.1 2/4] virtio-net-test: accept
 variable length argument in pci_test_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, ppandit@redhat.com, pbonzini@redhat.com

On 2018-12-03 11:06, Jason Wang wrote:
> This allows flexibility to be reused for all kinds of command line
> used by other tests.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  tests/virtio-net-test.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
