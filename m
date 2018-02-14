Received: from eggs.gnu.org ([2001:4830:134:3::10]:45486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1elxOX-0000dV-0f
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1elxOS-0005eq-2u
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:46:45 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:44547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1elxOR-0005eh-U2
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:46:40 -0500
Received: by mail-ua0-f193.google.com with SMTP id x4so13659315uaj.11
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 05:46:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180214133434.GB7545@stefanha-x1.localdomain>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180213173429.19501-2-stefanha@redhat.com>
	<20180213180918.GY573@redhat.com>
	<20180214010111.GB15103@lemon.usersys.redhat.com>
	<20180214133434.GB7545@stefanha-x1.localdomain>
From: Fam Zheng <famz@redhat.com>
Date: Wed, 14 Feb 2018 21:45:58 +0800
Message-ID: <CAK1Eb9=9g3Xx0-Sws46k0ufzTuCMMiHFqOTxRnkX89pa19dvVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Feb 14, 2018 at 9:34 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Wed, Feb 14, 2018 at 09:01:11AM +0800, Fam Zheng wrote:
> Fam, if you want it dropped, let me know.  Otherwise, we can leave it
> in if there is no further discussion.

Yeah, I think we can drop block/arm/s390/ppc and rely on get_maintainer.pl here.

Fam
