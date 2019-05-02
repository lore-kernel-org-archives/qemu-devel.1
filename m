Received: from eggs.gnu.org ([209.51.188.92]:51491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hLzJI-0000FV-Nw
	for qemu-devel@nongnu.org; Wed, 01 May 2019 20:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hLzJH-0001SN-Hg
	for qemu-devel@nongnu.org; Wed, 01 May 2019 20:10:48 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hLzJH-0001JL-8C
	for qemu-devel@nongnu.org; Wed, 01 May 2019 20:10:47 -0400
Received: by mail-ed1-x544.google.com with SMTP id w37so595764edw.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 17:10:30 -0700 (PDT)
Date: Thu, 2 May 2019 00:10:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190502001026.s4kit4ygz7mqdbgt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190430034412.12935-1-richardw.yang@linux.intel.com>
	<155675118046.10667.9255070406416571267@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155675118046.10667.9255070406416571267@c2072b67cc0c>
Subject: Re: [Qemu-devel] [PATCH 0/3] Cleanup migration/ram.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richardw.yang@linux.intel.com, fam@euphon.net, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com

On Wed, May 01, 2019 at 03:53:01PM -0700, no-reply@patchew.org wrote:
>Patchew URL: https://patchew.org/QEMU/20190430034412.12935-1-richardw.yang@linux.intel.com/
>
>
>
>Hi,
>
>This series failed the docker-mingw@fedora build test. Please find the testing commands and
>their output below. If you have Docker installed, you can probably reproduce it
>locally.
>
>=== TEST SCRIPT BEGIN ===
>#!/bin/bash
>time make docker-test-mingw@fedora SHOW_ENV=1 J=14 NETWORK=1
>=== TEST SCRIPT END ===
>
>
>
>
>The full log is available at
>http://patchew.org/logs/20190430034412.12935-1-richardw.yang@linux.intel.com/testing.docker-mingw@fedora/?type=message.

Where can I see the test case?

>---
>Email generated automatically by Patchew [https://patchew.org/].
>Please send your feedback to patchew-devel@redhat.com

-- 
Wei Yang
Help you, Help me
