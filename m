Received: from eggs.gnu.org ([2001:4830:134:3::10]:54447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdIh-00089b-2F
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdIc-0000Hq-4E
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:12:11 -0500
References: <1478094287-15009-1-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <85e7c088-cead-6fac-c916-03e6e9b4f9c5@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 14:12:05 +0300
MIME-Version: 1.0
In-Reply-To: <1478094287-15009-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] trivial changes on util/mmap-alloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, eblake@redhat.com, armbru@redhat.com, mst@redhat.com

02.11.2016 16:44, Cao jin wrote:
> Cao jin (2):
>   util/mmap-alloc: check parameter before using
>   util/mmap-alloc: refactor a little bit for readability
> 
>  util/mmap-alloc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Applied (finally) to -trivial, thank you very much!

/mjt
