Received: from eggs.gnu.org ([2001:4830:134:3::10]:43816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX31A-0003Xz-8Y
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX314-0003st-Qz
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:49:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gX312-0003pa-Mf
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:49:26 -0500
References: <154460890212.8343.10509987157027697685@02a1dbf831e2>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <62c4d238-3a51-bc11-d2b4-3136ee4583d5@redhat.com>
Date: Wed, 12 Dec 2018 12:49:19 +0100
MIME-Version: 1.0
In-Reply-To: <154460890212.8343.10509987157027697685@02a1dbf831e2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] Set minimum compiler versions to GCC
 4.8 and Clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org
Cc: peter.maydell@linaro.org, famz@redhat.com

On 2018-12-12 11:01, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1544606032-16924-1-git-send-email-thuth@redhat.com/
> 
> Hi,
> 
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=1 J=8
> === TEST SCRIPT END ===
> 
> The full log is available at
> http://patchew.org/logs/1544606032-16924-1-git-send-email-thuth@redhat.com/testing.docker-mingw@fedora/?type=message.

That looks like a networking error?

 Thomas
