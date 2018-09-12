Received: from eggs.gnu.org ([2001:4830:134:3::10]:40367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fzzvR-00020U-D1
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fzzvM-0002rr-D0
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:51:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fzzvL-0002qt-VL
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:50:56 -0400
References: <20180903043900.28592-1-zhangckid@gmail.com>
	<CAK3tnv+FV_Bq10sUU4_p-ma63rU5_dGgSMNK1WkLN2uNhVLj=A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4bfecce9-8036-4a26-7ad1-9c41831ba8b0@redhat.com>
Date: Wed, 12 Sep 2018 15:50:43 +0800
MIME-Version: 1.0
In-Reply-To: <CAK3tnv+FV_Bq10sUU4_p-ma63rU5_dGgSMNK1WkLN2uNhVLj=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V12 00/19] COLO: integrate colo frame with
 block replication and COLO proxy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com



On 2018=E5=B9=B409=E6=9C=8810=E6=97=A5 16:16, Zhang Chen wrote:
> Hi All.
> Have any comments?
> Ping...
>
> Thanks
> Zhang Chen

I've queued them with some tweaks on the commit log.

Please refer the comment of patch 1 and send me a patch on top for a=20
better comment.

Thanks
