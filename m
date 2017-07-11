Received: from eggs.gnu.org ([2001:4830:134:3::10]:42386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dUkY5-00063m-GD
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dUkY4-00049J-Lx
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:05:13 -0400
References: <1499678755-5633-1-git-send-email-gengdongjiu@huawei.com>
	<df74267a-3f6f-b6f5-432f-40f8c04ab1f1@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <56f91e49-da0f-1093-1dd5-bc157d85605b@huawei.com>
Date: Tue, 11 Jul 2017 10:01:24 +0800
MIME-Version: 1.0
In-Reply-To: <df74267a-3f6f-b6f5-432f-40f8c04ab1f1@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhihui.gao@huawei.com

Hi Eric,

On 2017/7/10 21:54, Eric Blake wrote:
> On 07/10/2017 04:25 AM, Dongjiu Geng wrote:
>> (1) Add related APEI/HEST table structures and  macros, these
>>     definition refer to ACPI 6.1 and UEFI 2.6 spec.
> 
> Your mail is missing In-Reply-To: and References: headers, which makes
> it appear as a new top-level thread for each patch.  You'll want to
> figure out why you didn't properly link back to your 0/3 cover letter
> with Message-ID: <1499678736-5244-1-git-send-email-gengdongjiu@huawei.com>

sorry for that and thanks for the pointing out. I will use Laszlo's suggested method
to change it. and resend the patchset.

$ git config --bool sendemail.thread       true
$ git config --bool sendemail.chainreplyto false
