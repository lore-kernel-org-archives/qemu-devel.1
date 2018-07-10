Received: from eggs.gnu.org ([2001:4830:134:3::10]:58303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fciIs-00009E-Tg
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fciIo-0008Bi-JD
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:22:58 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:42229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fciIo-0008B5-Am
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:22:54 -0400
Received: by mail-pf0-x234.google.com with SMTP id l9-v6so3353447pff.9
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 19:22:54 -0700 (PDT)
Date: Tue, 10 Jul 2018 12:22:44 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20180710122244.7466489f@aik.ozlabs.ibm.com>
In-Reply-To: <20180702062644.48040-1-aik@ozlabs.ru>
References: <20180702062644.48040-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [GIT PULL for qemu-pseries] pseries: Update SLOF
 firmware image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Mon,  2 Jul 2018 16:26:44 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The following changes since commit edb1fb337f65f82fe32b989c4f018efe85c1dddb:
> 
>   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> 
> are available in the git repository at:
> 
>   git@github.com:aik/qemu.git tags/qemu-slof-20180702
> 
> for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe85c1dddb:
> 
>   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> 
> ----------------------------------------------------------------
> 
> I just missed a couple of gcc 8.1 fixes and thought I can still squeeze
> them before the 3.0  soft freeze.
> 
> 
> *** Note: this is not for master, this is for pseries


Not good for 3.1 either?


--
Alexey
