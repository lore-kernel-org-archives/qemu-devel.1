Received: from eggs.gnu.org ([2001:4830:134:3::10]:46930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkoQX-0000ST-7u
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkoQS-0006kD-8Y
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:27:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dkoQS-0006jx-21
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:27:44 -0400
Date: Thu, 24 Aug 2017 17:27:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170824092737.GD1866@lemon>
References: <20170822044155.2451-1-famz@redhat.com>
	<b9454dbb-1663-6198-3f7e-4fbd5eb492fa@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9454dbb-1663-6198-3f7e-4fbd5eb492fa@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/10] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com

On Tue, 08/22 16:33, Kamil Rytarowski wrote:
> I propose to rename *bsd.img.xz (like netbsd.img.xz) to
> *bsd-version-arch.img.xz, like netbsd-7.1-amd64.img.xz. This will be
> more verbose about the version and leave room for image upgrades in future.

Good idea, will update.

Fam
