Received: from eggs.gnu.org ([2001:4830:134:3::10]:52020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnQmx-0001CS-Ie
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnQmu-0000to-Fm
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnQmu-0000rt-9H
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:49:44 -0400
Date: Thu, 31 Aug 2017 22:49:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831144929.GA29826@lemon.lan>
References: <20170831064302.14427-1-famz@redhat.com>
	<a0308f02-4716-87ea-5070-b57d567aae07@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0308f02-4716-87ea-5070-b57d567aae07@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/12] tests: Add VM based build tests
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
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com

On Thu, 08/31 16:04, Kamil Rytarowski wrote:
> Could we please add SmartOS image. It's an Illumos distribution,
> previously known as OpenSolaris.
> 
> qemu is actively maintained for SmartOS in pkgsrc.
> 
> The latest build fixes were introduced less than a week ago.
> https://github.com/NetBSD/pkgsrc/commit/f2608af5433f1491a92567bf570e9349dffbda7a
> 
> I'm going to submit the SmartOS patches to fix the build regardless of
> the decision.

When QEMU builds on it, and when someone composes an instruction page like 

> > https://wiki.qemu.org/Hosts/BSD

then probably yes.

Fam
