Received: from eggs.gnu.org ([2001:4830:134:3::10]:58293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0Ge3-000831-5j
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0GVu-0002E3-Nd
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:33:47 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d]:33706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1g0GVu-0002CK-GM
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:33:46 -0400
Received: by mail-ua1-x92d.google.com with SMTP id i4-v6so3426480uak.0
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 18:33:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <314d0a84-c0b5-3bbb-168d-360f5027a913@redhat.com>
References: <CAB3eZfv6QFAABhzxCKjVY_36j9th_3sbcbzaOQTGkm0mhJ-BoQ@mail.gmail.com>
	<314d0a84-c0b5-3bbb-168d-360f5027a913@redhat.com>
From: lampahome <pahome.chen@mirlab.org>
Date: Thu, 13 Sep 2018 09:33:44 +0800
Message-ID: <CAB3eZfsXekOx=rE_8dj59MUc9Qf5+37_iPzPq7wWHsCpuSjTNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] What kind of situation to use internal or external
 snapshot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

>
> In general, we've spent more resources developing external snapshots. So
> if you want the most support and the fastest response on resolving any
> issues that you may encounter, external snapshots are the way to go.
>
>
So internal snapshot is hard to use than external snapshot?
Is that because external snapshot is easier to roll back to any snapshot?
