Received: from eggs.gnu.org ([2001:4830:134:3::10]:53154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cDyGs-0000bP-N5
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cDyGp-0003AN-JZ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:45:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cDyGp-00039s-DO
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:45:47 -0500
References: <20161202210152.6880-1-lersek@redhat.com>
	<20161204192953-mutt-send-email-mst@kernel.org>
	<d5a6c326-46b0-b9ab-084f-d45868b76006@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5b9d8fb2-9a9d-5e5b-12e6-a9d062e14223@redhat.com>
Date: Mon, 5 Dec 2016 13:45:43 -0500
MIME-Version: 1.0
In-Reply-To: <d5a6c326-46b0-b9ab-084f-d45868b76006@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] scripts: add "git.orderfile" for
 ordering diff hunks by pathname patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>



On 12/05/2016 05:24 AM, Laszlo Ersek wrote:
> 
> I suggest we go ahead with this posting (or v1), then people can submit
> whatever improvements they deem fit, from their personal experience. I
> think the initial version should be minimal and non-controversial.
> 
> We've already spent a disproportionate amount of time discussing this item.
> 

ACK

> Thanks
> Laszlo
> 

Reviewed-by: John Snow <jsnow@redhat.com>
