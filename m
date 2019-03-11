Received: from eggs.gnu.org ([209.51.188.92]:53011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h3HKw-0004ZT-L9
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h3HKw-0004mq-0A
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:35:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h3HKv-0004ix-OI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:35:09 -0400
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
	<20181121115718.GN26577@redhat.com>
	<20181121072237-mutt-send-email-mst@kernel.org>
	<60500f8b-47e8-c530-076a-d7f14d0f0ee5@redhat.com>
	<20181121123929-mutt-send-email-mst@kernel.org>
	<bf59e483-d958-29ac-5e17-50f56405c629@redhat.com>
	<CAKXe6SLDcOJx+x_5wod6Pvy1oASEEQ06fbMDrWQnQg31FbQ_VQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <68be29a7-2af0-5ff5-f902-20dc1045f7b3@redhat.com>
Date: Mon, 11 Mar 2019 17:35:02 +0800
MIME-Version: 1.0
In-Reply-To: <CAKXe6SLDcOJx+x_5wod6Pvy1oASEEQ06fbMDrWQnQg31FbQ_VQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: tap: use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>


On 2019/3/10 =E4=B8=8B=E5=8D=887:26, Li Qiang wrote:
> Hi Jason,
>
> What's the status of this patch? I don't see it in upstream.
>
> Thanks,
> Li Qiang


Sorry, it would be in next pull request for sure.

Thanks
