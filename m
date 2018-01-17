Received: from eggs.gnu.org ([2001:4830:134:3::10]:41768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebgyP-0003Fz-6e
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebgyL-00083F-Uo
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:13:21 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebgyL-00081h-Nz
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:13:17 -0500
Received: by mail-wr0-f196.google.com with SMTP id f11so7187231wre.4
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 22:13:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171226025247.11082-1-famz@redhat.com>
References: <20171226025247.11082-1-famz@redhat.com>
From: Fam Zheng <fzheng@redhat.com>
Date: Wed, 17 Jan 2018 14:12:46 +0800
Message-ID: <CAK1Eb9mh_2a4-YU3RZtWkFzmOv3D0GaTzvraZvudq7ppdNjzTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, kchamart@redhat.com, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Ping?

On Tue, Dec 26, 2017 at 10:52 AM, Fam Zheng <famz@redhat.com> wrote:
> v5: Clean up the @table @var section first. [Kevin, Peter]
>
> Fam Zheng (2):
>   qemu-img.texi: Clean up parameter list
>   qemu-img: Document --force-share / -U
>
>  qemu-img.texi | 75 ++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 27 deletions(-)
>
> --
> 2.14.3
>
>
