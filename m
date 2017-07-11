Received: from eggs.gnu.org ([2001:4830:134:3::10]:40301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dUkOY-0002AW-AW
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 21:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dUkOX-0000eV-OL
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 21:55:22 -0400
References: <1499678755-5633-1-git-send-email-gengdongjiu@huawei.com>
	<df74267a-3f6f-b6f5-432f-40f8c04ab1f1@redhat.com>
	<d48ec6cf-03b6-bf2b-1bed-1e2c34aaf5f0@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <f37c8504-905b-5971-a487-e30870b19227@huawei.com>
Date: Tue, 11 Jul 2017 09:54:18 +0800
MIME-Version: 1.0
In-Reply-To: <d48ec6cf-03b6-bf2b-1bed-1e2c34aaf5f0@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/3] ACPI: Add new ACPI structures and
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Eric Blake <eblake@redhat.com>, mst@redhat.com, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhihui.gao@huawei.com

Dear,Laszlo

On 2017/7/10 22:04, Laszlo Ersek wrote:
> Yes, the git-send-email options to use are:
> 
>   --thread --no-chain-reply-to
> 
> Best to set them permanently in one's qemu clone,
> 
> $ git config --bool sendemail.thread       true
> $ git config --bool sendemail.chainreplyto false
> 
> This is called "shallow threading" (see git-send-email(1)).

great, thanks for your suggestion.
