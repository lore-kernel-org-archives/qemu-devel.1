Received: from eggs.gnu.org ([2001:4830:134:3::10]:49883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5BXQ-0004qw-KW
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5BXN-000441-9l
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:11:08 -0400
Date: Thu, 19 Oct 2017 22:10:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171019141058.GB29815@lemon>
References: <150841324224.31292.4012464539983692364.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150841324224.31292.4012464539983692364.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] docker: fix out-of-tree 'make
 docker-test-build@debian-powerpc-cross'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, 10/19 13:40, Greg Kurz wrote:
> Without this patch, it fails with:
> 
> IOError: [Errno 2] No such file or directory:
>  'tests/docker/dockerfiles/debian-apt-fake.sh'
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reasonable. Queued, thanks!

Fam
