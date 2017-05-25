Received: from eggs.gnu.org ([2001:4830:134:3::10]:42809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDnNj-0007Gp-Az
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDnNi-0000rP-Fl
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:40:27 -0400
Date: Thu, 25 May 2017 15:40:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170525074012.GB8487@lemon.lan>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<3e999ccc-5a8b-9111-06eb-d10bb83f6c43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e999ccc-5a8b-9111-06eb-d10bb83f6c43@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/18] Block layer thread safety, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com

On Wed, 05/24 10:32, Paolo Bonzini wrote:
> 
> Ping?
> 

Looks good to me except for the mingw 32bit build failure reported by patchew:

http://patchew.org/QEMU/20170511144208.24075-1-pbonzini@redhat.com/

Do you want to fix it?

Fam
