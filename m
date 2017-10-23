Received: from eggs.gnu.org ([2001:4830:134:3::10]:55538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e6jiV-0004lT-5I
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 16:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e6jiT-0003HR-Cz
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 16:52:59 -0400
Date: Mon, 23 Oct 2017 13:52:45 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <150860960347.476.5295412873363332990@b58463cdfd5f>
Message-ID: <alpine.DEB.2.10.1710231352260.574@sstabellini-ThinkPad-X260>
References: <150860960347.476.5295412873363332990@b58463cdfd5f>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, famz@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org

On Sat, 21 Oct 2017, no-reply@patchew.org wrote:
> Makefile:30: recipe for target 'git-submodule-update' failed
> make: *** [git-submodule-update] Error 1
> make: *** Waiting for unfinished jobs....
> make: *** wait: No child processes.  Stop.
> === OUTPUT END ===
> 
> Test command exited with code: 2

This is a false positive, isn't it?
