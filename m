Received: from eggs.gnu.org ([2001:4830:134:3::10]:42114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0fFP-00044d-Tz
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 23:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0fFP-0000DN-7u
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 23:58:23 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935]:42427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1g0fFM-00007D-64
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 23:58:22 -0400
Received: by mail-ua1-x935.google.com with SMTP id w7-v6so6435018uan.9
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 20:58:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cd6350f4-d8b9-217e-fcb6-19b84f4ad7c9@redhat.com>
References: <CAB3eZfv6QFAABhzxCKjVY_36j9th_3sbcbzaOQTGkm0mhJ-BoQ@mail.gmail.com>
	<314d0a84-c0b5-3bbb-168d-360f5027a913@redhat.com>
	<CAB3eZfsXekOx=rE_8dj59MUc9Qf5+37_iPzPq7wWHsCpuSjTNQ@mail.gmail.com>
	<cd6350f4-d8b9-217e-fcb6-19b84f4ad7c9@redhat.com>
From: lampahome <pahome.chen@mirlab.org>
Date: Fri, 14 Sep 2018 11:58:17 +0800
Message-ID: <CAB3eZfubzAKOnuJKOvBFHb7qvTau7iOKfMZa83xirV50itDCtQ@mail.gmail.com>
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

In general case, what's difference between internal and external snapshot?
I mean in some user situation.

Ex: If I want to all snapshots in only one qcow2, I should use internal
snapshot.

thx
