Received: from eggs.gnu.org ([2001:4830:134:3::10]:48681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fzCk0-0004tf-NF
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fzCbA-0004wx-CI
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:10:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fzCbA-0004vJ-5W
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F8772E9BF
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 03:10:46 +0000 (UTC)
References: <1534495027-6621-1-git-send-email-jasowang@redhat.com>
	<20180907164811-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <42a56a37-768f-93de-f9e5-b67633faa193@redhat.com>
Date: Mon, 10 Sep 2018 11:10:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180907164811-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-headers: update to mainline
 5c60a7389d79
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org



On 2018=E5=B9=B409=E6=9C=8808=E6=97=A5 04:48, Michael S. Tsirkin wrote:
> On Fri, Aug 17, 2018 at 04:37:06PM +0800, Jason Wang wrote:
>> Sync linux headers to 5c60a7389d79 ("Merge tag 'for-linus-4.19-ofs1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux").
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> so there will be a new version of this as ioctl has changed, right?
>

Want me to repost the series or another patch to sync it on top?

Thanks
